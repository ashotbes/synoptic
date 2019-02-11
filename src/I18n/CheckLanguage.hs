{-# LANGUAGE OverloadedStrings #-}

module I18n.CheckLanguage where

import            Data.Text
import            Types.Lang

checkLanguage :: Text -> Either Text Language
checkLanguage lang = do
   if lang == "Ru" || lang == "ru"
     then Right Ru
     else
       if lang == "En" || lang == "en"
       then Right En
       else
         if lang == "Am" || lang == "am"
           then Right Am
           else Left $ "The language you specified is not supported!"
