{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}

module AllWithCities where

import           Data.Text

import           Types.Lang

-- Список городов

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

citiesForUser :: Language -> City -> Text
citiesForUser En messageInEn = showCityInEnglish  messageInEn
citiesForUser Ru messageInRu = showCityInRussian  messageInRu
citiesForUser Am messageInAm = showCityInArmenian messageInAm

supportedCities :: Language -> [Text]
supportedCities lang = Prelude.map (citiesForUser lang) [Aragatsotn .. Yerevan]

cityInArmenian :: Text -> Maybe City
cityInArmenian city =
   if | city == "Արագածոտն"   -> Just Aragatsotn
      | city == "Արարատ"      -> Just Ararat
      | city == "Արմավիր"     -> Just Armavir
      | city == "Դիլիջան"     -> Just Dilijan
      | city == "Գեղարքունիք" -> Just Gegharkunik
      | city == "Գյումրի"     -> Just Gyumri
      | city == "Կոտայք"      -> Just Kotayk
      | city ==  "Սյունիք"    -> Just Syunik
      | city == "Վանաձոր"     -> Just Vanadzor
      | city == "Երեւան"      -> Just Yerevan
      | otherwise             -> Nothing

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

cityInRussian :: Text -> Maybe City
cityInRussian city =
  if | city == "Арагацотн"  -> Just Aragatsotn
     | city == "Арарат"     -> Just  Ararat
     | city == "Армавир"    -> Just  Armavir
     | city == "Дилижан"    -> Just  Dilijan
     | city == "Гехаркуник" -> Just  Gegharkunik
     | city == "Гюмри"      -> Just  Gyumri
     | city == "Котайк"     -> Just  Kotayk
     | city == "Ширак"      -> Just  Shirak
     | city == "Ванадзор"   -> Just  Vanadzor
     | city == "Ереван"     -> Just  Yerevan
     | otherwise            -> Nothing

textToCity :: Language -> Text -> Maybe City
textToCity En cityInEn = cityInEnglish  cityInEn
textToCity Ru cityInRu = cityInRussian  cityInRu
textToCity Am cityInAm = cityInArmenian cityInAm

data City
   = Aragatsotn
   | Ararat
   | Armavir
   | Dilijan
   | Gegharkunik
   | Gyumri
   | Kotayk
   | Shirak
   | Syunik
   | Vanadzor
   | Yerevan
   deriving (Read, Enum, Eq, Ord, Show)
