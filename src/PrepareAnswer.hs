{-# LANGUAGE OverloadedStrings #-}

module PrepareAnswer where

import           Types.UserPhrases
import           Data.Aeson            ( decode )
import qualified Data.ByteString.Lazy  as BSL
import           Data.List             ( find )
import           Data.Maybe            ( fromJust )
import           Data.Text
import           Data.Time.Clock       ( UTCTime )
import           Data.Time.Clock.POSIX ( utcTimeToPOSIXSeconds )
import           Network.HTTP.Client   ( Response, responseBody )

import           ShowAnswer            ( showInfo )
import           Types.FullWeatherInfo

-- Функция,которая выдает информацию о погоде

prepareAnswer
  :: Response BSL.ByteString -> UTCTime -> Text -> UserPhrase -> Text
prepareAnswer response dateFromUser cityFromUser phrase  = finalPhrase
    where
      finalPhrase    = showInfo forecastToMain cityFromUser dateFromUser phrase
      forecastToMain = prepareMainInfo (fromJust $ oneForecast)
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

findOurForecast :: [InfoAboutForecast] -> UTCTime -> Maybe InfoAboutForecast
findOurForecast allForecasts dateFromUser =
  let ourForecast = Data.List.find (\forecast ->
                                        dt forecast == utcTimeToPOSIXSeconds dateFromUser)
                                   allForecasts
  in case ourForecast of
         Nothing  -> Nothing
         Just our -> Just our

-- Извлекаем нужные нам данные из прогноза

prepareMainInfo :: InfoAboutForecast -> MainWeatherInfo
prepareMainInfo = main
