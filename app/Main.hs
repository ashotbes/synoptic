{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf        #-}

module Main where

import           AskWeatherFromServer  ( askWeather )
import           CheckDateAndCity      ( UserError (..), getCityFromUser,
                                         getDateFromUser, reportAboutProblem )

import           Data.Text
import           Data.Text.IO          as TIO
import           Data.Time.Clock
import           System.FilePath.Posix
import           System.Directory
import           Data.Aeson as A
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BSL
import qualified Data.Yaml             as Y

import           DecodeYaml
import           Types.UserPhrases     ( UserPhrase (..))
import           ConversionWithCities  ( supportedCities )
import           PrepareAnswer         ( prepareAnswer )
import           Types.Lang            ( Language (..), MessageForUser (..) )

main :: IO ()
main = do
    fileNames <- listDirectory "/home/ashot/synoptic/i18n"
    print fileNames
    language <- TIO.getLine
    if (Data.Text.toLower $ language) == "ru"
      then do
        content <- BSL.readFile "/home/ashot/Рабочий стол/ru.yaml"
        currentTime <- getCurrentTime
        dateFromUser <- Prelude.getLine
        let parsedContent = parseYaml $ content
            answer = messErrorCity parsedContent
            date = getDateFromUser currentTime dateFromUser triedLanguage
            case date of
              Left problemWithDate -> TIO.putStrLn problemWithDate
              Right correctDate -> do
                TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities triedLanguage
                cityFromUser <- TIO.getLine
                let city = getCityFromUser cityFromUser triedLanguage
                case city of
                  Nothing -> reportAboutProblem triedLanguage InvalidCity
                  Just correctCity -> do
                    response <- askWeather (correctDate, correctCity)
                    let answer = prepareAnswer triedLanguage response correctDate correctCity
                    TIO.putStrLn answer
