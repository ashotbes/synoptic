{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module ShowAnswer where

--import           DecodeYaml
import           Data.Text
import           Data.Time.Clock
import           Types.FullWeatherInfo
import           Types.UserPhrases

convToText :: Show a => a -> Text
convToText = Data.Text.pack . show

showInfo ::
  MainWeatherInfo -> Text -> UTCTime -> UserPhrase -> Text
showInfo (MainWeatherInfo temp1 _ _ pressure1 _ _ humidity1 _ )
         cityFromUser
         dateFromUser
         (UserPhrase _ _ _ messFor on1 temper press pressDes1 hum _ _ _ _) =
   messFor <> cityFromUser <> (on1) <> (Data.Text.take 10 $ convToText $ dateFromUser) <> ":"
           <> "\n"
           <> (temper) <> (convToText $ kToC $ (round $ temp1 )) <> "°"
           <> "\n"
           <> (press) <> (convToText $ prConversion $ pressure1) <> ( pressDes1)
           <> "\n"
           <> (hum) <> (convToText $ humidity1) <> "%"

-- Конвертация

kToC :: Int -> Int
kToC kel = kel - 273

prConversion :: Double -> Int
prConversion pres = round $ (pres / 1.333)
