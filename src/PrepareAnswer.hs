{-# LANGUAGE OverloadedStrings #-}

module PrepareAnswer where

import           Data.Aeson            (decode)
import qualified Data.ByteString.Lazy  as BSL
import           Data.List             (find)
import           Data.Maybe            (fromJust)
import           Data.Text
import           Data.Time.Clock       (UTCTime)
import           Data.Time.Clock.POSIX (utcTimeToPOSIXSeconds)
import           Network.HTTP.Client   (Response, responseBody)

import           GettingUserDate
import           Types.FullWeatherInfo
import           Types.Lang

-- Функция,которая выдает строку с информацией о погоде

prepareAnswer :: Language -> Response BSL.ByteString -> UTCTime -> Text
prepareAnswer lang response dateFromUser = finalPhrase
    where
      finalPhrase    = showInfo lang forecastToMain
      forecastToMain = prepareMainInfo oneForecast
      oneForecast    = findOurForecast listOfForecast dateFromUser
      listOfForecast = extractListOfForecasts (fromJust weatherValues)
      weatherValues  = parseRawJSON . responseBody $ response

-- Извлекаем со строки тип FullWeatherInfo

parseRawJSON :: BSL.ByteString -> Maybe FullWeatherInfo
parseRawJSON rawJSON =
  let result = decode rawJSON :: Maybe FullWeatherInfo
  in case result of
      Just ok -> Just ok
      Nothing -> Nothing

-- Извлекаем информацию о прогнозе из FullWeatherInfo

extractListOfForecasts :: FullWeatherInfo -> [InfoAboutForecast]
extractListOfForecasts = list

-- Получаем нужный нам прогноз

findOurForecast :: [InfoAboutForecast] -> UTCTime -> InfoAboutForecast
findOurForecast allForecasts dateFromUser =
  let ourForecast = Data.List.find (\forecast ->
                                        dt forecast == utcTimeToPOSIXSeconds dateFromUser)
                                   allForecasts
  in case ourForecast of
         Nothing  -> error "Беда"
         Just our -> our

-- Извлекаем нужные нам данные из прогноза

prepareMainInfo :: InfoAboutForecast -> MainWeatherInfo
prepareMainInfo = main

-- Показываем информацию о погоде

showInfo :: Language -> MainWeatherInfo -> Text
showInfo lang (MainWeatherInfo temp1 _ _ pressure1 _ _ _ _ ) =
   pack $ show (messageForUser lang MessageForecast) ++ show ( kToC $ (round $ temp1)) ++ " C, pressure: " ++ show pressure1 ++ " mm hg"
-- Кельвин в Цельсий

kToC :: Int -> Int
kToC kel = kel - 273
