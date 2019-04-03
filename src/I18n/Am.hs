{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module I18n.Am where

import           Data.Text

import           Types.City


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
