{-# LANGUAGE OverloadedStrings #-}

module PrepareAnswer where

import           Data.Aeson            (decode)
import qualified Data.ByteString.Lazy  as BSL
import           Data.List             (find)
import           Data.Maybe            (fromJust)
import           Data.Text
import           Data.Time.Clock       (UTCTime)
import           Data.Time.Clock.POSIX (utcTimeToPOSIXSeconds)
import           Network.HTTP.Client   (Response, responseBody)
import           Types.UserPhrases

import           ShowAnswer            (showInfo)
import           Types.FullWeatherInfo

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
