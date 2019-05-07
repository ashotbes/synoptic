{-# LANGUAGE LambdaCase          #-}
{-# LANGUAGE MultiWayIf          #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import           AskWeatherFromServer  (askWeather)
import           CheckDateAndCity      (getDateFromUser)
import           PrepareAnswer         (prepareAnswer)
import           Types.UserPhrases     (UserPhrase (..))

import           Control.Exception
import qualified Data.ByteString       as B
import qualified Data.List             as L
import qualified Data.Text             as T
import qualified Data.Text.IO          as TIO
import           Data.Time.Clock
import qualified Data.Yaml             as Y
import           System.Directory
import           System.Exit
import           System.FilePath.Posix

main :: IO ()
main = do
    currentDirectory <- getCurrentDirectory
    -- Check a directory with language files.
    let langDirectory = currentDirectory </> "i18n"
    allLangFiles <- listDirectory langDirectory >>= \case
        [] -> die $ "Sorry, but I cannot continue without language support. "
                    <> "Please make sure the directory "
                    <> langDirectory
                    <> " exists and contains at least one language .yaml-file."
        allLangFiles -> return allLangFiles
    -- We use pure names of language files to form a list for the user.
    let pureNamesOfLangs = map takeBaseName allLangFiles
    putStrLn $ "Please choose a language: " ++ L.intercalate ", " pureNamesOfLangs
    -- Ask user for a language.
    language <- TIO.getLine
    let preparedLanguage = T.toLower language -- User may use different case on his keyboard.
        Just correspondingLangFile = L.find (\langFile -> preparedLanguage == T.pack (takeBaseName langFile))
                                            allLangFiles
        pathToLangFile = langDirectory </> correspondingLangFile
    langFileContent <- try (B.readFile pathToLangFile) >>= \case
        Left (someProblem :: IOException) -> die $ "Sorry, I cannot open language file "
                                                   <> pathToLangFile
                                                   <> ": "
                                                   <> show someProblem
        Right langFileContent -> return langFileContent
    -- Parse file's content to a structure.
    phrasesForUser <- case Y.decodeThrow langFileContent :: Maybe UserPhrase of
        Nothing             -> die "Sorry, I cannot parse language file."
        Just phrasesForUser -> return phrasesForUser
    -- Extract cities' names (for human and for server).
    let cityNames = cities phrasesForUser
        pairsOfCityNames = [ let names = T.splitOn (",") twoNames
                                 [nameForHuman, nameForServer] = L.filter (not . T.null) names
                             in (nameForHuman, nameForServer)
                           | twoNames <- cityNames
                           ]
        (allNamesForHumans, _) = unzip pairsOfCityNames
    -- Show all supported cities (already in chosen language).
    TIO.putStrLn $ messageChooseForecastCity phrasesForUser
    TIO.putStrLn $ T.intercalate ", " allNamesForHumans
    cityFromUser <- TIO.getLine
    -- Find corresponding name of the city, but for the server.
    cityNameForServer <- case L.lookup cityFromUser pairsOfCityNames of
        Nothing -> do
            TIO.putStrLn $ messageErrorWrongCity phrasesForUser
            die "Sorry!"
        Just cityNameForServer -> return cityNameForServer
    -- Ask user for a date of forecast.
    TIO.putStrLn $ messageChooseForecastDate phrasesForUser
    -- We need actual date to check user's date.
    currentTime <- getCurrentTime
    dateFromUser <- Prelude.getLine
    correctDate <- case getDateFromUser currentTime dateFromUser phrasesForUser of
        Left problemWithDate -> TIO.putStrLn problemWithDate >> die "Sorry, I cannot continue!"
        Right correctDate    -> return correctDate
    -- Ask a weather from the server.
    responseFromServer <- askWeather cityNameForServer
    -- Form the final response for the user.
    let finalAnswer = prepareAnswer responseFromServer
                                    correctDate
                                    cityFromUser
                                    phrasesForUser
    TIO.putStrLn finalAnswer
