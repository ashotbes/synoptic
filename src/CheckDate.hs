{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module CheckDate where

import           Data.Text
import           Data.Time.Clock      ( NominalDiffTime, UTCTime, diffUTCTime )
import           Data.Time.Format     ( defaultTimeLocale, parseTimeM )

import           Types.UserPhrases    ( UserPhrase (..) )

-- функция округления

round' :: NominalDiffTime -> Integer
round' mark 
    | mark < 0 = -1
    | mark2 > 100 = 100
    | otherwise = mark2
    where mark2 = round mark

-- Получаем дату от пользователя и здесь же проверяем

checkDateFromUser :: UTCTime -> String -> UserPhrase -> Either Text UTCTime
checkDateFromUser currentTime dateFromUser (UserPhrase _ _ _ _ _ _ _ _ _ errorDate _ _ _)  = do
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
