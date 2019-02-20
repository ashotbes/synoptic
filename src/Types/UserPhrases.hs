{-# LANGUAGE DeriveGeneric #-}

module Types.UserPhrases where

import           Data.Aeson
import           Data.Text
import           GHC.Generics

instance FromJSON MessageForUser
instance ToJSON   MessageForUser

data MessageForUser = MessageForUser
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
    messageUnexpectedError    :: Text }
   deriving (Show,Generic)
