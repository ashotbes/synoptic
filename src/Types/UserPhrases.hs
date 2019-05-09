{-# LANGUAGE DeriveGeneric #-}

module Types.UserPhrases where

import           Data.Aeson   ( ToJSON, FromJSON )
import           Data.Text    ( Text)
import           GHC.Generics ( Generic )

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
    cities                    :: [Text]
   } deriving (Show,Generic)
