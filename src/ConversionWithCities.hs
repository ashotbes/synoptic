{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module ConversionWithCities where

import           Data.Text

import           I18n.Am
import           I18n.En
import           I18n.Ru
import           Types.City
import           Types.Lang

-- Список городов

supportedCities :: Language -> [Text]
supportedCities lang = Prelude.map (citiesForUser lang) [Aragatsotn .. Yerevan]

-- I18N Для городов и создания списка

textToCity :: Language -> Text -> Maybe City
textToCity En cityInEn = cityInEnglish  cityInEn
textToCity Ru cityInRu = cityInRussian  cityInRu
textToCity Am cityInAm = cityInArmenian cityInAm

citiesForUser :: Language -> City -> Text
citiesForUser En messageInEn = showCityInEnglish  messageInEn
citiesForUser Ru messageInRu = showCityInRussian  messageInRu
citiesForUser Am messageInAm = showCityInArmenian messageInAm

-- Сначала превращаем текст в список городов,а потом показываем на нужном пользователю языке
