{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           AskWeather      (askWeather)
import           Data.Text
import           Data.Text.IO    as TIO
import           Data.Time.Clock
import           GettingUserDate (UserError (..), getCityFromUser,
                                  getDateFromUser, checkLanguage,
                                  messageForUser, reportAboutProblem,
                                  supportedCities)

import           PrepareAnswer   (prepareAnswer)
import           Types.Lang

main :: IO ()
main = do
    Prelude.putStrLn "Please,select language!  Ru | En | Am"
    language <- TIO.getLine
    let lang = checkLanguage language
    case lang of
      Left problemWithLang -> TIO.putStrLn problemWithLang
      Right language1 -> do
          TIO.putStrLn $ messageForUser language1 MessageChooseForecastDate
          dateFromUser <- TIO.getLine
          currentTime <- getCurrentTime
          let date = getDateFromUser dateFromUser currentTime language1
          case date of
            Left problemWithDate -> TIO.putStrLn problemWithDate
            Right correctDate -> do
              TIO.putStrLn $ messageForUser language1 MessageChooseForecastCity
              TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities language1
              cityFromUser <- TIO.getLine
              let city = getCityFromUser cityFromUser language1
              case city of
                  Nothing -> reportAboutProblem language1 InvalidCity
                  Just correctCity -> do
                      response <- askWeather (correctDate, correctCity)
                      let answer = prepareAnswer language1 response correctDate correctCity
                      TIO.putStrLn answer
