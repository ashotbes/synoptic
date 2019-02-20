{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module ShowAnswer where

import           CheckDateAndCity
import           ConversionWithCities
import           Data.Text
import           Data.Time.Clock
import           Types.City
import           Types.FullWeatherInfo
import           Types.Lang

showInfo :: Language -> MainWeatherInfo -> City -> UTCTime -> Text
showInfo lang (MainWeatherInfo temp1 _ _ pressure1 _ _ humidity1 _ ) cityFromUser dateFromUser =
   messageForUser lang MessageForecast <> citiesForUser lang cityFromUser <> messageForUser lang On
   <> ( Data.Text.take 10 $ utcTimeToText $ dateFromUser) <> ": "
   <> messageForUser lang MessageAboutTemperature
   <> (intToText $ kToC $ (round $ temp1 )) <> "°"
   <> messageForUser lang MessageAboutPressure <> (intToText $ prConversion $ pressure1)
   <> messageForUser lang PressureDesignation
   <> messageForUser lang Humidity <> ( intToText $ humidity1 ) <> "%"

-- Конвертация

kToC :: Int -> Int
kToC kel = kel - 273

intToText :: Int -> Text
intToText = Data.Text.pack . show

utcTimeToText :: UTCTime -> Text
utcTimeToText = Data.Text.pack . show

prConversion :: Double -> Int
prConversion pres = round $ (pres / 1.333)
