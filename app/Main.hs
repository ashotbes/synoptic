{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

module Main where

import           Data.Text.IO as TIO
import           Data.Text
import           Data.Time.Clock
import           Data.Maybe
import           Data.Either
import           AskWeather      (askWeather)
import           GettingUserDate ( getLanguageFromUser
                                 , reportAboutProblem
                                 , messageForUser
                                 , supportedCities
                                 , getDateFromUser
                                 , getCityFromUser
                                 , UserError
                                 )

import           Types.Lang
import           PrepareAnswer   (prepareAnswer)

main :: IO ()
main = do
    lang <- getLanguageFromUser
    currentTime <- getCurrentTime
    TIO.putStrLn $ messageForUser lang MessageChooseForecastDate
    dateFromUser        <- TIO.getLine
    TIO.putStrLn $ messageForUser lang MessageChooseForecastCity
    TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities lang
    cityFromUser <- TIO.getLine
    city <- getCityFromUser cityFromUser lang
    date <- getDateFromUser dateFromUser currentTime lang
    response <- askWeather (date, city)
    let answer = prepareAnswer lang response date city
    TIO.putStrLn answer
