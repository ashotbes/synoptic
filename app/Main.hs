{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           AskWeatherFromServer  (askWeather)
import           CheckDateAndCity      (getCityFromUser, getDateFromUser,
                                        reportAboutProblem)

import qualified Data.ByteString       as B
import           Data.List             (filter, unzip)
import           Data.Text             as T
import           Data.Text.IO          as TIO
import           Data.Time.Clock
import qualified Data.Yaml             as Y
import           System.Directory
import           System.Exit
import           System.FilePath.Posix
import           Types.UserPhrases     (UserPhrase (..))

import           DecodeYaml
import           PrepareAnswer         (prepareAnswer)

main :: IO ()
main = do
  currentDir <- getCurrentDirectory
  let langFile    = currentDir </> "i18n" </> "ru.yaml"
      langFolder  = currentDir </> "i18n"
  con <- B.readFile $ langFolder </> langFile
  let parsedContent = Y.decodeThrow con :: Maybe UserPhrase
  case parsedContent of
    Nothing -> die "Sorry,we cant Decode this file!"
    Just phrase -> do
      let cityNames = (takeCityNames $ phrase) -- :: [Text]
          allCItyNames = takeAllElem $ cityNames
          result' = [ let names = T.splitOn (",") twoNames
                          [nameForHuman, nameForServer] = Data.List.filter (not . T.null) names
                      in (nameForHuman, nameForServer)
                    | twoNames <- cityNames
                    ]
          (allNamesForHumans, _allNamesForServer) = unzip result'
      TIO.putStrLn $ T.intercalate "," allNamesForHumans
  --    TIO.putStrLn $ Data.Text.concat $ cityNames
  --    TIO.putStrLn allCities
--      print $ fst . snd $ (Data.Text.splitAt 10 allCities )
--      print $ (Prelude.map Prelude.head $  Data.Text.splitOn "," (Data.Text.concat $  cityNames))
      TIO.putStrLn $  (choosLang $ phrase )
      --TIO.putStrLn $ T.concat $ (splitOn ", " allCItyNames)
      print $ (splitOn ", " allCItyNames)
      fileNames <- listDirectory langFolder
      print fileNames
      language <- TIO.getLine
      if (T.toLower $ language) == "ru"
        then do
          TIO.putStrLn (choosDate $ phrase)
          TIO.putStrLn $ T.concat cityNames
          currentTime <- getCurrentTime
          dateFromUser <- Prelude.getLine
          let date = getDateFromUser currentTime dateFromUser phrase
          case date of
            Left problemWithDate -> TIO.putStrLn problemWithDate
            Right correctDate -> do
              TIO.putStrLn $ (choosCity $ phrase)
              TIO.putStrLn $ T.concat $ (splitOn ", " $ T.concat $ (takeCityNames $ phrase))
              cityFromUser <- TIO.getLine
              let city = getCityFromUser cityNames cityFromUser
              case city of
                Nothing -> reportAboutProblem phrase
                Just correctCity -> do
                  response <- askWeather (correctDate, correctCity)
                  let answer = prepareAnswer response correctDate correctCity phrase
                  TIO.putStrLn answer
                  else TIO.putStrLn "Please select one of the suggested languages!"
