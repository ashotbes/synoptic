{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module I18n.Ru where

import           Data.Text
import           Types.City
import           Types.Lang

showMessageInRussian :: MessageForUser -> Text
showMessageInRussian MessageChooseLanguage     = "Пожалуйста,выберите язык!"
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

cityInRussian :: Text -> Maybe City
cityInRussian city =
  if | city == "Арагацотн"  -> Just Aragatsotn
     | city == "Арарат"     -> Just Ararat
     | city == "Армавир"    -> Just Armavir
     | city == "Дилижан"    -> Just Dilijan
     | city == "Гехаркуник" -> Just Gegharkunik
     | city == "Гюмри"      -> Just Gyumri
     | city == "Котайк"     -> Just Kotayk
     | city == "Ширак"      -> Just Shirak
     | city == "Сюник"      -> Just Syunik
     | city == "Ванадзор"   -> Just Vanadzor
     | city == "Ереван"     -> Just Yerevan
     | otherwise            -> Nothing

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
