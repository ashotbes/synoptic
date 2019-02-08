{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module GettingUserDate where

--import           Data.Either      (fromLeft, isLeft, rights)
--import           Data.Maybe       (fromJust, isNothing)
import           Data.Text
import           Data.Text.IO     as TIO
--import           Data.Time        (getCurrentTime)
import           Data.Time.Clock  (NominalDiffTime, UTCTime, diffUTCTime)
import           Data.Time.Format (defaultTimeLocale, parseTimeM)

import           I18n.Am
import           I18n.En
import           I18n.Ru
import           Types.City
import           Types.Lang

data UserError = InvalidDate Text | InvalidCity
    deriving (Show)

-- Сообщаем о проблемах,которые могут возникнуть

reportAboutProblem :: Language -> UserError -> IO ()
reportAboutProblem lang (InvalidDate _ ) = TIO.putStrLn $ messageForUser lang MessageErrorWrongDate
reportAboutProblem lang InvalidCity      = TIO.putStrLn $ messageForUser lang MessageErrorWrongCity

-- Показываем сообщения на нужном пользователю языке

messageForUser :: Language -> MessageForUser -> Text
messageForUser En messageInEn = showMessageInEnglish  messageInEn
messageForUser Ru messageInRu = showMessageInRussian  messageInRu
messageForUser Am messageInAm = showMessageInArmenian messageInAm

citiesForUser :: Language -> City -> Text
citiesForUser En messageInEn = showCityInEnglish  messageInEn
citiesForUser Ru messageInRu = showCityInRussian  messageInRu
citiesForUser Am messageInAm = showCityInArmenian messageInAm

textToCity :: Language -> Text -> Maybe City
textToCity En cityInEn = cityInEnglish  cityInEn
textToCity Ru cityInRu = cityInRussian  cityInRu
textToCity Am cityInAm = cityInArmenian cityInAm

-- функция округления

round' :: NominalDiffTime -> Integer
round' mark
    | mark < 0 = -1
    | mark2 > 100 = 100
    | otherwise = mark2
    where mark2 = round mark

-- Список городов

supportedCities :: Language -> [Text]
supportedCities lang = Prelude.map (citiesForUser lang) [Aragatsotn .. Yerevan]

checkLanguage :: Text -> Either Text Language
checkLanguage lang = do
   if lang == "Ru" || lang == "ru"
     then Right Ru
     else
       if lang == "En" || lang == "en"
       then Right En
       else
         if lang == "Am" || lang == "am"
           then Right Am
           else Left $ "The language you specified is not supported!"

-- Получаем дату от пользователя и здесь же проверяем

getDateFromUser :: Text -> UTCTime -> Language -> Either Text UTCTime
getDateFromUser date currentTime lang = do
  let textToString = show $ date
      dayFromUser = parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M:%S" (textToString ++ "12:00:00") :: Maybe UTCTime
  case dayFromUser of
    Nothing -> Left $ messageForUser lang MessageErrorWrongDate
    Just validDay -> do
         let differenceInNominalDiffTime = diffUTCTime validDay currentTime
             secondsInDay = 86400
             differenceInDays = round' $ differenceInNominalDiffTime / secondsInDay
         if differenceInDays >= 0 && differenceInDays <= 5
             then Right validDay
             else Left $ messageForUser lang MessageErrorWrongDate

-- Получаем город от пользователя и здесь же проверяем

getCityFromUser :: Text -> Language -> Maybe City
getCityFromUser city lang = do
    if city `elem` supportedCities lang
       then textToCity lang city
       else Nothing
