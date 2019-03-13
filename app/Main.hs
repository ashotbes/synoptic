{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf        #-}

module Main where

import           AskWeatherFromServer  ( askWeather )
import           CheckDateAndCity      ( UserError (..), getCityFromUser,
                                         getDateFromUser, messageForUser,
                                         reportAboutProblem )

import           Data.Text
import           Data.Text.IO          as TIO
import           Data.Time.Clock
import           System.FilePath.Posix
import           System.Directory
import qualified Data.ByteString as B
import qualified Data.Yaml             as Y

import           DecodeYaml
import           Types.UserPhrases     ( UserPhrase (..))
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
    if (Data.Text.toLower $ language) == (Data.Text.toLower $ "ru" )
      then do
        content <- B.readFile "/home/ashot/Рабочий стол/ru.yaml"
        let parsedContent = Y.decodeEither' content :: Either Y.ParseException MessageForUser
            answer = messErrorCity parsedContent
            lang = checkLanguage language
        case lang of
          Left problemWithLang -> TIO.putStrLn problemWithLang
          Right triedLanguage -> do
            currentTime <- getCurrentTime
            dateFromUser <- Prelude.getLine
            let date = getDateFromUser currentTime dateFromUser triedLanguage
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
                    else TIO.putStrLn $  "Please select a language from the list"
