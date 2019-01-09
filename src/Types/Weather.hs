{-# LANGUAGE DeriveGeneric #-}

module Types.Weather where

import           Data.Aeson.Types (FromJSON, ToJSON)
import           Data.Text        (Text)
import           GHC.Generics     (Generic)

instance ToJSON   Weather

instance FromJSON Weather

-- JSON тип

data Weather = Weather
    { id          :: Int
    , main        :: Text
    , description :: Text
    , icon        :: Text
    } deriving (Show,Generic)

-- Не могу добавить в Types, имена полей совпадают
