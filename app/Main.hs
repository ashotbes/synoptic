{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           AskWeatherFromServer ( askWeather )
import           CheckDateAndCity     ( getCityFromUser,
                                        getDateFromUser, reportAboutProblem
                                      )

import           Control.Exception
import           Data.Text
import           Data.Text.IO         as TIO
import           Data.Time.Clock
--import           System.FilePath.Posix
import qualified Data.ByteString      as B
import qualified Data.Yaml            as Y
import           Types.UserPhrases    ( UserPhrase (..) )
import           System.Directory

import           DecodeYaml
import           ConversionWithCities ( supportedCities )
import           PrepareAnswer        ( prepareAnswer )
import           Types.Lang           ( Language (..) )

main :: IO ()
main = do
  content <- B.readFile "/home/ashot/synoptic/i18n/ru.yaml"
  let parsedContent = Y.decodeEither' content :: Either Y.ParseException UserPhrase
  case parsedContent of
    Left err -> throw $ err
    Right phrase -> do
      TIO.putStrLn (choosLang $ phrase)
      fileNames <- getDirectoryContents "/home/ashot/synoptic/i18n"
      print fileNames
      language <- TIO.getLine
      if (Data.Text.toLower $ language) == "ru"
        then do  
          TIO.putStrLn (choosDate $ phrase)
          currentTime <- getCurrentTime
          dateFromUser <- Prelude.getLine
          let date = getDateFromUser currentTime dateFromUser phrase
          case date of
            Left problemWithDate -> TIO.putStrLn problemWithDate
            Right correctDate -> do
              TIO.putStrLn $ (choosCity $ phrase)
              TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities Ru
              --TIO.putStrLn $ (takeCityName $ phrase)
              cityFromUser <- TIO.getLine
              let city = getCityFromUser cityFromUser Ru
              case city of
                Nothing -> reportAboutProblem phrase
                Just correctCity -> do
                  response <- askWeather (correctDate, correctCity)
                  let answer = prepareAnswer Ru response correctDate correctCity phrase
                  TIO.putStrLn answer
                  else return ()
