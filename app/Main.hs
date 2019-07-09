{-# LANGUAGE LambdaCase          #-}
{-# LANGUAGE MultiWayIf          #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where 

import           AskWeatherFromServer         ( askWeather )
import           CheckDate                    ( checkDateFromUser )
import           PrepareAnswer                ( prepareAnswer )
import             Types.UserPhrases            ( UserPhrase (..) )
 
import           Network.HTTP.Simple          
import           Control.Exception            ( IOException, try )
import qualified Data.ByteString       as B   ( readFile )
import qualified Data.List             as L   ( find, filter ,lookup, intercalate )
import qualified Data.Text             as T   ( toLower, pack, splitOn, null, intercalate, toTitle )
import qualified Data.Text.IO          as TIO ( putStrLn, getLine )
import           Data.Time.Clock              ( getCurrentTime )
import qualified Data.Yaml             as Y   ( decodeThrow )
import           System.Directory             ( getCurrentDirectory, listDirectory )
import           System.Exit                  ( die, exitFailure )
import           System.FilePath.Posix        ( takeBaseName, (</>) )

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
    correspondingLangFile <- case L.find (\langFile -> preparedLanguage == T.pack (takeBaseName langFile)) allLangFiles of 
                                     Nothing -> die "You have entered an incorrect or unsupported language, please select one of the languages above!"
                                     Just correspondingLangFile -> return correspondingLangFile 
    let pathToLangFile = langDirectory </> correspondingLangFile
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
    cityFromUser <- T.toTitle <$> TIO.getLine 
    -- Find corresponding name of the city, but for the server.
    cityNameForServer <- case L.lookup cityFromUser pairsOfCityNames of
        Nothing -> do
            TIO.putStrLn $ messageErrorWrongCity phrasesForUser
            exitFailure 
        Just cityNameForServer -> return cityNameForServer
    -- Ask user for a date of forecast.
    TIO.putStrLn $ messageChooseForecastDate phrasesForUser
    -- We need actual date to check user's date.
    currentTime <- getCurrentTime
    dateFromUser <- Prelude.getLine
    correctDate <- case checkDateFromUser currentTime dateFromUser phrasesForUser of
        Left problemWithDate -> TIO.putStrLn problemWithDate >> exitFailure
        Right correctDate    -> return correctDate
    -- Ask a weather from the server.
    responseFromServer <- askWeather cityNameForServer
    let someThing = getResponseStatusCode responseFromServer 
    if someThing /= 200 
        then TIO.putStrLn $ messageUnexpectedError phrasesForUser 
        else do 
            let finalAnswer = prepareAnswer responseFromServer
                                             correctDate
                                             cityFromUser
                                             phrasesForUser 
            TIO.putStrLn finalAnswer

 -- Form the final response for the user.


