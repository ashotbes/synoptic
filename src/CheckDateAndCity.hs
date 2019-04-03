{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module CheckDateAndCity where

import           Data.Text
import           Data.Text.IO         as TIO
import           Data.Time.Clock      ( NominalDiffTime, UTCTime, diffUTCTime )
import           Data.Time.Format     ( defaultTimeLocale, parseTimeM )

--import           DecodeYaml
import           Types.UserPhrases
import           ConversionWithCities
import           Types.City
import           Types.Lang

-- Сообщаем о проблемах,которые могут возникнуть

reportAboutProblem :: UserPhrase -> IO ()
reportAboutProblem (UserPhrase _ _ _ _ _ _ _ _ _ _ _ errorCity _ ) = TIO.putStrLn errorCity

-- функция округления

round' :: NominalDiffTime -> Integer
round' mark
    | mark < 0 = -1
    | mark2 > 100 = 100
    | otherwise = mark2
    where mark2 = round mark

-- Получаем дату от пользователя и здесь же проверяем

getDateFromUser :: UTCTime -> String -> UserPhrase -> Either Text UTCTime
getDateFromUser currentTime dateFromUser (UserPhrase _ _ _ _ _ _ _ _ _ _ errorDate _ _ )  = do
    let dayFromUser = parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M:%S" (dateFromUser ++ " 12:00:00") :: Maybe UTCTime
    case dayFromUser of
      Nothing -> Left $ errorDate
      Just validDay -> do
           let differenceInNominalDiffTime = diffUTCTime validDay currentTime
               secondsInDay = 86400
               differenceInDays = round' $ differenceInNominalDiffTime / secondsInDay
           if differenceInDays >= 0 && differenceInDays <= 5
             then Right $ validDay
             else Left $ errorDate

-- Получаем город от пользователя и здесь же проверяем

getCityFromUser :: Text -> Language -> Maybe City
getCityFromUser city lang = do
    if city `elem` supportedCities lang
       then textToCity lang city
       else Nothing
