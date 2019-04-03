{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module I18n.En where

import           Data.Text

import           Types.City

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
