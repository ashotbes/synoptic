{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           AskWeatherFromServer (askWeather)
import           Data.Text
import           Data.Text.IO         as TIO
import           Data.Time.Clock
import           CheckDateAndCity     (UserError (..), getCityFromUser,
                                      getDateFromUser, messageForUser,
                                      reportAboutProblem)

import           I18n.CheckLanguage   (checkLanguage)
import           PrepareAnswer        (prepareAnswer)
import           Types.Lang           (MessageForUser (..))
import           ConversionWithCities (supportedCities)

main :: IO ()
main = do
    Prelude.putStrLn "Please,select language!  Ru | En | Am"
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
