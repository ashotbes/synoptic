{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           AskWeatherFromServer  ( askWeather )
import           CheckDateAndCity      ( UserError (..), getCityFromUser,
                                         getDateFromUser, messageForUser,
                                         reportAboutProblem )
--import           Data.Aeson
--import qualified Data.ByteString.Char8 as BS
import           Data.Text
import           Data.Text.IO          as TIO
import           Data.Time.Clock
--import qualified Data.Yaml             as Y
import           System.Directory

import           ConversionWithCities  ( supportedCities )
import           I18n.CheckLanguage    ( checkLanguage )
import           PrepareAnswer         ( prepareAnswer )
import           Types.Lang            ( Language (..), MessageForUser (..) )

main :: IO ()
main = do
    fileNames <- listDirectory "/home/ashot/synoptic/i18n"
    print fileNames
    TIO.putStrLn $ messageForUser En MessageChooseLanguage
    language <- TIO.getLine
    let lang = checkLanguage language
    case lang of
      Left problemWithLang -> TIO.putStrLn problemWithLang
      Right triedLanguage -> do
          TIO.putStrLn $ messageForUser triedLanguage MessageChooseForecastDate
          currentTime <- getCurrentTime
          dateFromUser <- Prelude.getLine
          let date = getDateFromUser currentTime dateFromUser triedLanguage
          case date of
            Left problemWithDate -> TIO.putStrLn problemWithDate
            Right correctDate -> do
              TIO.putStrLn $ messageForUser triedLanguage MessageChooseForecastCity
              TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities triedLanguage
              cityFromUser <- TIO.getLine
              let city = getCityFromUser cityFromUser triedLanguage
              case city of
                  Nothing -> reportAboutProblem triedLanguage InvalidCity
                  Just correctCity -> do
                      response <- askWeather (correctDate, correctCity)
                      let answer = prepareAnswer triedLanguage response correctDate correctCity
                      TIO.putStrLn answer
