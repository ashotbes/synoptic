{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import           AskWeather      (askWeather)
import           Data.Text
import           Data.Text.IO    as TIO
import           Data.Time.Clock
import           GettingUserDate (UserError (..), getCityFromUser,
                                  getDateFromUser, getLanguageFromUser,
                                  messageForUser, reportAboutProblem,
                                  supportedCities)

import           PrepareAnswer   (prepareAnswer)
import           Types.Lang

main :: IO ()
main = do
    lang <- getLanguageFromUser
    TIO.putStrLn $ messageForUser lang MessageChooseForecastDate
    dateFromUser <- TIO.getLine
    currentTime <- getCurrentTime
    let date = getDateFromUser dateFromUser currentTime lang
    case date of
        Left problemWithDate -> TIO.putStrLn problemWithDate
        Right correctDate -> do
            TIO.putStrLn $ messageForUser lang MessageChooseForecastCity
            TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities lang
            cityFromUser <- TIO.getLine
            let city = getCityFromUser cityFromUser lang
            case city of
                Nothing -> reportAboutProblem lang InvalidCity
                Just correctCity -> do
                    response <- askWeather (correctDate, correctCity)
                    let answer = prepareAnswer lang response correctDate correctCity
                    TIO.putStrLn answer
