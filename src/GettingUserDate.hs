{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module GettingUserDate where

import           Data.Either      (fromLeft, isLeft, rights)
import           Data.Maybe       (fromJust, isNothing)
import           Data.Text
import           Data.Text.IO     as TIO (putStrLn)
import           Data.Time        (getCurrentTime)
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

-- функция округления

round' :: NominalDiffTime -> Integer
round' mark
    | mark < 0 = -1
    | mark2 > 100 = 100
    | otherwise = mark2
    where mark2 = round mark

-- Список городов

supportedCities :: [City]
supportedCities = [Aragatsotn .. Yerevan]

getLanguageFromUser :: IO Language
getLanguageFromUser = do
   Prelude.putStrLn "Please,select language!  Ru | En | Am"
   lang <- getLine
   if lang == "Ru" || lang == "ru"
     then return Ru
     else
       if lang == "En" || lang == "en"
       then return En
       else
         if lang == "Am" || lang == "am"
           then return Am
           else error "The language you specified is not supported"

-- Главная функция этого модуля,которая получает и дату, и город, и проверяет данные

getUserData :: Language -> IO (Either UserError (UTCTime, City))
getUserData lang = do
    date <- getDateFromUser lang
    if isLeft date
      then
        let errorMessage = fromLeft "" date in return $ Left $ InvalidDate errorMessage
        else do
          cityFromUser <- getCityFromUser lang
          if | isNothing cityFromUser -> return $ Left InvalidCity
             | otherwise              -> let [realDate] = rights [date] in return $ Right (realDate, fromJust cityFromUser)

-- Получаем дату от пользователя и здесь же проверяем

getDateFromUser :: Language -> IO (Either Text UTCTime)
getDateFromUser lang = do
  TIO.putStrLn $ messageForUser lang MessageChooseForecastDate
  currentTime <- getCurrentTime
  date        <- Prelude.getLine
  let dayFromUser = parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M:%S" (date ++ " 12:00:00") :: Maybe UTCTime
  case dayFromUser of
    Nothing -> return $ Left $ messageForUser lang MessageErrorWrongDate
    Just validDay -> do
         let differenceInNominalDiffTime = diffUTCTime validDay currentTime
             secondsInDay = 86400
             differenceInDays = round' $ differenceInNominalDiffTime / secondsInDay
         if differenceInDays >= 0 && differenceInDays <= 5
             then return $ Right validDay
             else return $ Left $ messageForUser lang MessageErrorWrongDate

-- Получаем город от пользователя и здесь же проверяем

getCityFromUser :: Language -> IO (Maybe City)
getCityFromUser lang = do
    TIO.putStrLn $ messageForUser lang MessageChooseForecastCity
    print [Aragatsotn .. Yerevan]
    cityFromUser <- Prelude.getLine
    let cityAsString = Prelude.map show supportedCities
    if cityFromUser `elem` cityAsString
       then return $ Just (read cityFromUser :: City)
       else return Nothing