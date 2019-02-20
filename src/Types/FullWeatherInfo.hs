{-# LANGUAGE DeriveGeneric #-}

module Types.FullWeatherInfo where

import           Data.Aeson.Types      ( FromJSON, ToJSON )
import           Data.Text             ( Text )
import           Data.Time.Clock.POSIX ( POSIXTime )
import           GHC.Generics          ( Generic )

import           Types.Weather         ( Weather )

-- JSON типы

instance ToJSON   FullWeatherInfo
instance ToJSON   InfoAboutCity
instance ToJSON   InfoAboutForecast
instance ToJSON   Location
instance ToJSON   Sys
instance ToJSON   Wind
instance ToJSON   Clouds
instance ToJSON   MainWeatherInfo

instance FromJSON FullWeatherInfo
instance FromJSON InfoAboutCity
instance FromJSON InfoAboutForecast
instance FromJSON Location
instance FromJSON Sys
instance FromJSON Wind
instance FromJSON Clouds
instance FromJSON MainWeatherInfo

data FullWeatherInfo = FullWeatherInfo
    { cod     :: Text
    , message :: Double
    , cnt     :: Int
    , list    :: [InfoAboutForecast]
    , city    :: InfoAboutCity
    } deriving (Show,Generic)

data InfoAboutCity = InfoAboutCity
    { id         :: Int
    , name       :: Text
    , coord      :: Location
    , country    :: Text
    , population :: Int
    } deriving (Show,Generic)

data InfoAboutForecast = InfoAboutForecast
    { dt      :: POSIXTime
    , dt_txt  :: Text
    , main    :: MainWeatherInfo
    , weather :: [Weather]
    , clouds  :: Clouds
    , wind    :: Wind
    , sys     :: Sys
    } deriving (Show,Generic)

data Location = Location
    { lat :: Double
    , lon :: Double
    } deriving (Show,Generic)

data Clouds = Clouds
    { all :: Int
    } deriving (Show,Generic)

data Wind = Wind
    { speed :: Double
    , deg   :: Double
    } deriving (Show,Generic)

data Sys = Sys
    { pod :: Text
    } deriving (Show,Generic)

data MainWeatherInfo = MainWeatherInfo
    { temp       :: Double
    , temp_min   :: Double
    , temp_max   :: Double
    , pressure   :: Double
    , sea_level  :: Double
    , grnd_level :: Double
    , humidity   :: Int
    , temp_kf    :: Double
    } deriving (Show,Generic)
