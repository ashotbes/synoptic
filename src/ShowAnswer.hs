{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module ShowAnswer where

--import            CheckDateAndCity
import            ConversionWithCities
import            Data.Text
import            Data.Time.Clock
import            Types.City
import            Types.FullWeatherInfo
--import            Types.UserPhrases
import            Types.Lang
--import            Data.Maybe
--import            DecodeYaml (choosLang)

convToText :: Show a => a -> Text
convToText = Data.Text.pack . show

showInfo :: Language -> MainWeatherInfo -> City -> UTCTime -> Text 
showInfo lang (MainWeatherInfo temp1 _ _ pressure1 _ _ humidity1 _ ) cityFromUser dateFromUser =
  ( Data.Text.take 10 $ convToText $ dateFromUser) <> ": " <> citiesForUser lang cityFromUser
  <> (convToText $ kToC $ (round $ temp1 )) <> "°"
  <> (convToText $ prConversion $ pressure1)
  <> ( convToText $ humidity1 ) <> "%"

-- Конвертация

kToC :: Int -> Int
kToC kel = kel - 273

prConversion :: Double -> Int
prConversion pres = round $ (pres / 1.333)
