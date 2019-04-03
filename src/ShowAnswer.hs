{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module ShowAnswer where

--import           DecodeYaml
import           Types.UserPhrases
import           ConversionWithCities
import           Data.Text
import           Data.Time.Clock
import           Types.City
import           Types.FullWeatherInfo
import           Types.Lang

convToText :: Show a => a -> Text
convToText = Data.Text.pack . show

showInfo ::
  Language -> MainWeatherInfo -> City -> UTCTime -> UserPhrase -> Text
showInfo lang (MainWeatherInfo temp1 _ _ pressure1 _ _ humidity1 _ ) cityFromUser dateFromUser (UserPhrase _ _ _ _ messFor on1 temper press pressDes1 hum _ _ _ ) =
   messFor <> citiesForUser lang cityFromUser <> (on1)
   <> ( Data.Text.take 10 $ convToText $ dateFromUser) <> ":" <> (temper)
   <> (convToText $ kToC $ (round $ temp1 )) <> "°" <> ( press)
   <> (convToText $ prConversion $ pressure1) <> ( pressDes1) <> ( hum)
   <> ( convToText $ humidity1 ) <> "%"

-- Конвертация

kToC :: Int -> Int
kToC kel = kel - 273

prConversion :: Double -> Int
prConversion pres = round $ (pres / 1.333)
