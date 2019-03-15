{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module CheckDateAndCity where

import           Data.Text
import           Data.Text.IO         as TIO
import           Data.Time.Clock      ( NominalDiffTime, UTCTime, diffUTCTime )
import           Data.Time.Format     ( defaultTimeLocale, parseTimeM )

import           ConversionWithCities
import           Types.City
import           Types.Lang

data UserError = InvalidDate Text | InvalidCity
    deriving (Show)

-- Сообщаем о проблемах,которые могут возникнуть

reportAboutProblem :: UserError -> IO ()
reportAboutProblem  (InvalidDate _ ) = TIO.putStrLn "Eroroehuaisd"
reportAboutProblem InvalidCity      = TIO.putStrLn "Eroroehuaisd"

-- функция округления

round' :: NominalDiffTime -> Integer
round' mark
    | mark < 0 = -1
    | mark2 > 100 = 100
    | otherwise = mark2
    where mark2 = round mark

-- Получаем дату от пользователя и здесь же проверяем

getDateFromUser :: UTCTime -> String -> Either Text UTCTime
getDateFromUser currentTime dateFromUser = do
    let dayFromUser = parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M:%S" (dateFromUser ++ " 12:00:00") :: Maybe UTCTime
    case dayFromUser of
      Nothing -> Left $ "messageForUser triedLanguage MessageErrorWrongDate"
      Just validDay -> do
           let differenceInNominalDiffTime = diffUTCTime validDay currentTime
               secondsInDay = 86400
               differenceInDays = round' $ differenceInNominalDiffTime / secondsInDay
           if differenceInDays >= 0 && differenceInDays <= 5
             then Right $ validDay
             else Left $ "messageForUser triedLanguage MessageErrorWrongDate"

-- Получаем город от пользователя и здесь же проверяем

getCityFromUser :: Text -> Language -> Maybe City
getCityFromUser city lang = do
    if city `elem` supportedCities lang
       then textToCity lang city
       else Nothing
