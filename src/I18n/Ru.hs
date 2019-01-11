{-# LANGUAGE OverloadedStrings #-}

module I18n.Ru where

import           Data.Text
import           Types.Lang

showMessageInRussian :: MessageForUser -> Text
showMessageInRussian MessageChooseForecastDate = "Пожалуйста, укажите дату прогноза!"
showMessageInRussian MessageChooseForecastCity = "Пожалуйста, укажите город!"
showMessageInRussian MessageForecast           = "Информация о погоде: "
showMessageInRussian MessageAboutTemperature   = "Температура: "
showMessageInRussian MessageAboutPressure      = " Давление: "
showMessageInRussian PressureDesignation       = " мм рт.ст"
showMessageInRussian MessageErrorWrongDate     = "Вы ввели неверную дату,пожалуйста исправьте её!"
showMessageInRussian MessageErrorWrongCity     = "Вы ввели неверный город,пожалуйста,укажите город из списка!"
showMessageInRussian MessageUnexpectedError    = "Что-то пошло не так)"
