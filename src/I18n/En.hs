{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE OverloadedStrings #-}

module I18n.En where

import           Data.Text

import           Types.Lang
import           Types.City

showCityInEnglish :: City -> Text
showCityInEnglish Aragatsotn  = "Aragatsotn"
showCityInEnglish Ararat      = "Ararat"
showCityInEnglish Armavir     = "Armavir"
showCityInEnglish Dilijan     = "Dilijan"
showCityInEnglish Gegharkunik = "Gegharkunik"
showCityInEnglish Gyumri      = "Gyumri"
showCityInEnglish Kotayk      = "Kotayk"
showCityInEnglish Shirak      = "Shirak"
showCityInEnglish Syunik      = "Syunik "
showCityInEnglish Vanadzor    = "Vanadzor"
showCityInEnglish Yerevan     = "Yerevan"

showMessageInEnglish :: MessageForUser -> Text
showMessageInEnglish MessageChooseForecastDate = "Please, enter a date for the forecast!"
showMessageInEnglish MessageChooseForecastCity = "Please, specify a city for the forecast!"
showMessageInEnglish MessageForecast           = "Forecast for "
showMessageInEnglish On                        = " at "
showMessageInEnglish MessageAboutTemperature   = "Temperature is: "
showMessageInEnglish MessageAboutPressure      = " Air pressure is: "
showMessageInEnglish PressureDesignation       = " mm Hg "
showMessageInEnglish Humidity                  = "Humidity: "
showMessageInEnglish MessageErrorWrongDate     = "You entered an invalid Date!"
showMessageInEnglish MessageErrorWrongCity     = "You entered an invalid City!"
showMessageInEnglish MessageUnexpectedError    = "Something went wrong"

cityInEnglish :: Text -> Maybe City
cityInEnglish city =
  if | city == "Yerevan"    -> Just Yerevan
     | city == "Ararat"     -> Just Ararat
     | city == "Armavir"    -> Just Armavir
     | city == "Dilijan"    -> Just Dilijan
     | city == "Gegharkunik"-> Just Gegharkunik
     | city == "Gyumri"     -> Just Gyumri
     | city == "Kotayk"     -> Just Kotayk
     | city == "Shirak"     -> Just Shirak
     | city == "Syunik "    -> Just Syunik
     | city == "Vanadzor"   -> Just Vanadzor
     | city == "Aragatsotn" -> Just Aragatsotn
     | otherwise            -> Nothing
