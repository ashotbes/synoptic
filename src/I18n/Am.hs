{-# LANGUAGE OverloadedStrings #-}

module I18n.Am where

import           Data.Text

import           Types.Lang
import           Types.City

showCityInArmenian :: City -> Text
showCityInArmenian Aragatsotn  = "Արագածոտն"
showCityInArmenian Ararat      = "Արարատ"
showCityInArmenian Armavir     = "Արմավիր"
showCityInArmenian Dilijan     = "Դիլիջան"
showCityInArmenian Gegharkunik = "Գեղարքունիք"
showCityInArmenian Gyumri      = "Գյումրի"
showCityInArmenian Kotayk      = "Կոտայք"
showCityInArmenian Shirak      = "Շիրակ"
showCityInArmenian Syunik      = "Սյունիք"
showCityInArmenian Vanadzor    = "Վանաձոր"
showCityInArmenian Yerevan     = "Երեւան"

showMessageInArmenian :: MessageForUser -> Text
showMessageInArmenian MessageChooseForecastDate = "Նշեք կանխատեսման ամսաթիվը"
showMessageInArmenian MessageChooseForecastCity = "Նշեք քաղաքը կանխատեսման համար"
showMessageInArmenian MessageForecast           = "Եղանակի մասին տեղեկություններ: "
showMessageInArmenian On                        = ""
showMessageInArmenian MessageAboutTemperature   = "Ջերմաստիճանը: "
showMessageInArmenian MessageAboutPressure      = " Ճնշումը: "
showMessageInArmenian PressureDesignation       = " տոր "
showMessageInArmenian Humidity                  = "Խոնավությունը: "
showMessageInArmenian MessageErrorWrongDate     = "Դուք անվավեր ամսաթիվ եք մուտքագրել, ուղղեք այն:"
showMessageInArmenian MessageErrorWrongCity     = "Դուք մուտքագրել եք անվավեր քաղաք"
showMessageInArmenian MessageUnexpectedError    = "Ինչ որ բան այնպես չգնաց"

convertCityInArmenian :: Text -> City
convertCityInArmenian "Արագածոտն"   = Aragatsotn
convertCityInArmenian "Արարատ"      = Ararat
convertCityInArmenian "Արմավիր"     = Armavir
convertCityInArmenian "Դիլիջան"     = Dilijan
convertCityInArmenian "Գեղարքունիք" = Gegharkunik
convertCityInArmenian "Գյումրի"     = Gyumri
convertCityInArmenian "Կոտայք"      = Kotayk
convertCityInArmenian "Շիրակ"       = Shirak
convertCityInArmenian "Սյունիք"     = Syunik
convertCityInArmenian "Վանաձոր"     = Vanadzor
convertCityInArmenian "Երեւան"      = Yerevan
