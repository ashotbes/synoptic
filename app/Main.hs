{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Text.IO as TIO
import           Data.Text

import           AskWeather      (askWeather)
import           GettingUserDate (getLanguageFromUser, getUserData,
                                 reportAboutProblem, messageForUser ,
                                 supportedCities
                                 )

import                           Types.Lang

import           PrepareAnswer   (prepareAnswer)

main :: IO ()
main = do
    lang <- getLanguageFromUser
    currentTime <- getCurrentTime
    TIO.putStrLn $ messageForUser lang MessageChooseForecastDate
    date        <- TIO.getLine
    TIO.putStrLn $ messageForUser lang MessageChooseForecastCity
    TIO.putStrLn $ Data.Text.intercalate ", " $ supportedCities lang
    cityFromUser <- TIO.getLine
    userData <- getUserData cityFromUser lang
    case userData of
        Left problem -> reportAboutProblem lang problem
        Right (date,city) -> do
            response <- askWeather (date, city)
            let answer = prepareAnswer lang response date city
            TIO.putStrLn answer
