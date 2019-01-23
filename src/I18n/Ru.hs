{-# LANGUAGE OverloadedStrings #-}

module I18n.Ru where

import           Data.Text
import           Types.Lang
import           Types.City

showCityInRussian :: City -> Text
showCityInRussian Aragatsotn  = "Арагацотн"
showCityInRussian Ararat      = "Арарат"
showCityInRussian Armavir     = "Армавир"
showCityInRussian Dilijan     = "Дилижан"
showCityInRussian Gegharkunik = "Гехаркуник"
showCityInRussian Gyumri      = "Гюмри"
showCityInRussian Kotayk      = "Котайк"
showCityInRussian Shirak      = "Ширак"
showCityInRussian Syunik      = "Сюник"
showCityInRussian Vanadzor    = "Ванадзор"
showCityInRussian Yerevan     = "Ереван"

showMessageInRussian :: MessageForUser -> Text
showMessageInRussian MessageChooseForecastDate = "Пожалуйста, укажите дату прогноза!"
showMessageInRussian MessageChooseForecastCity = "Пожалуйста, укажите город!"
showMessageInRussian MessageForecast           = "Информация о погоде в "
showMessageInRussian On                        = " на "
showMessageInRussian MessageAboutTemperature   = " Температура: "
showMessageInRussian MessageAboutPressure      = " Давление: "
showMessageInRussian PressureDesignation       = " мм рт.ст "
showMessageInRussian Humidity                  = "Относительная влажность: "
showMessageInRussian MessageErrorWrongDate     = "Вы ввели неверную дату,пожалуйста исправьте её!"
showMessageInRussian MessageErrorWrongCity     = "Вы ввели неверный город,пожалуйста,укажите город из списка!"
showMessageInRussian MessageUnexpectedError    = "Что-то пошло не так)"

cityInRussian :: Text -> City
cityInRussian "Арагацотн" = Aragatsotn
cityInRussian "Арарат"     = Ararat
cityInRussian "Армавир"    = Armavir
cityInRussian "Дилижан"    = Dilijan
cityInRussian "Гехаркуник" = Gegharkunik
cityInRussian "Гюмри"      = Gyumri
cityInRussian "Котайк"     = Kotayk
cityInRussian "Ширак"      = Shirak
cityInRussian "Сюник"      = Syunik
cityInRussian "Ванадзор"   = Vanadzor
cityInRussian "Ереван"     = Yerevan
