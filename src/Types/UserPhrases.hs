{-# LANGUAGE DeriveGeneric #-}

module Types.UserPhrases where

import           Data.Aeson
import           Data.Text
import           GHC.Generics

instance ToJSON   UserPhrase
instance FromJSON UserPhrase

data UserPhrase = UserPhrase
  { messageChooseLanguage     :: Text ,
    messageChooseForecastDate :: Text ,
    messageChooseForecastCity :: Text ,
    messageForecast           :: Text ,
    on                        :: Text ,
    messageAboutTemperature   :: Text ,
    messageAboutPressure      :: Text ,
    pressureDesignation       :: Text ,
    humidity                  :: Text ,
    messageErrorWrongDate     :: Text ,
    messageErrorWrongCity     :: Text ,
    messageUnexpectedError    :: Text ,
    cities                    :: ([Text])
   } deriving (Show,Generic)
