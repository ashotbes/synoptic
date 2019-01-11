{-# LANGUAGE OverloadedStrings #-}

module I18n.En where

import           Data.Text

import           Types.Lang

showMessageInEnglish :: MessageForUser -> Text
showMessageInEnglish MessageChooseForecastDate = "Please, enter a date for the forecast!"
showMessageInEnglish MessageChooseForecastCity = "Please, specify a city for the forecast!"
showMessageInEnglish MessageForecast           = "Forecast: "
showMessageInEnglish MessageAboutTemperature   = "Temperature is: "
showMessageInEnglish MessageAboutPressure      = " Air pressure is: "
showMessageInEnglish PressureDesignation       = " mm Hg"
showMessageInEnglish MessageErrorWrongDate     = "You entered an invalid Date!"
showMessageInEnglish MessageErrorWrongCity     = "You entered an invalid City!"
showMessageInEnglish MessageUnexpectedError    = "Something went wrong"
