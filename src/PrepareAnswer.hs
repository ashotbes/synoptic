{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module PrepareAnswer where

import           Data.Aeson            ( decode )
import qualified Data.ByteString.Lazy  as BSL
import           Data.List             ( find )
import           Data.Maybe            ( fromJust )
import           Data.Text
import           Data.Time.Clock       ( UTCTime )
import           Data.Time.Clock.POSIX ( utcTimeToPOSIXSeconds )
import           Network.HTTP.Client   ( Response, responseBody )

import           Types.UserPhrases     ( UserPhrase(..) )
import           Types.FullWeatherInfo ( InfoAboutForecast (..),
                                         MainWeatherInfo (..) , FullWeatherInfo (..)
                                       )

prepareAnswer
  :: Response BSL.ByteString -> UTCTime -> Text -> UserPhrase -> Text
prepareAnswer response dateFromUser cityFromUser phrase = finalPhrase
    where
      finalPhrase    = showInfo forecastToMain cityFromUser dateFromUser phrase
      forecastToMain = main $ fromJust oneForecast
      oneForecast    = findOurForecast listOfForecast dateFromUser
      listOfForecast = list $ fromJust weatherValues
      weatherValues  = decode (responseBody response) :: Maybe FullWeatherInfo

findOurForecast :: [InfoAboutForecast] -> UTCTime -> Maybe InfoAboutForecast
findOurForecast allForecasts dateFromUser = Data.List.find (\forecast -> dt forecast == utcTimeToPOSIXSeconds dateFromUser)
                                                           allForecasts

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

convToText :: Show a => a -> Text
convToText = Data.Text.pack . show

kToC :: Int -> Int
kToC kel = kel - 273

prConversion :: Double -> Int
prConversion pres = round $ (pres / 1.333)
