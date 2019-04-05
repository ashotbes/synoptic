module DecodeYaml where

import           Control.Exception
import           Data.ByteString (ByteString)
import           Data.Text
--import qualified Data.Text.IO      as TIO
import qualified Data.Yaml         as Y
import           Types.UserPhrases

parseYaml :: ByteString -> Maybe UserPhrase
parseYaml rawYAML = do
    let result = Y.decodeEither' rawYAML :: Either Y.ParseException UserPhrase
    case result of
        Right ok -> Just ok
        Left prob -> throw $ prob

choosLang :: UserPhrase -> Text
choosLang (UserPhrase messChoosLang _ _ _ _ _ _ _ _ _ _ _ _) = messChoosLang

choosDate :: UserPhrase -> Text
choosDate (UserPhrase _ date _ _ _ _  _ _ _ _ _ _ _ ) = date

choosCity :: UserPhrase -> Text
choosCity (UserPhrase _ _ city _ _ _ _ _  _ _ _ _ _) = city

forecastInfo :: UserPhrase -> Text
forecastInfo (UserPhrase _ _ _ forecast _ _  _ _ _ _ _ _ _) = forecast

on' :: UserPhrase -> Text
on' (UserPhrase _ _ _ _ on1 _ _ _ _ _ _ _ _) = on1

tempInfo :: UserPhrase -> Text
tempInfo (UserPhrase _ _ _ _ _ temp _ _ _ _ _ _ _) = temp

pressInfo :: UserPhrase -> Text
pressInfo (UserPhrase _ _ _ _ _ _ pressure _ _ _ _ _ _) = pressure

pressDes :: UserPhrase -> Text
pressDes (UserPhrase _ _ _ _ _ _ _ press _ _ _ _ _) = press

infoAboutHumidity :: UserPhrase -> Text
infoAboutHumidity (UserPhrase _ _ _ _ _ _ _ _ _ humidity1 _ _ _) = humidity1

messthrowDate :: UserPhrase -> Text
messthrowDate (UserPhrase _ _ _ _ _ _ _ _ _ _ throwDate _ _) = throwDate

messthrowCity :: UserPhrase -> Text
messthrowCity( UserPhrase _ _ _ _ _ _ _ _ _  _ _ throwCity _) = throwCity

messUnexpectedthrow :: UserPhrase -> Text
messUnexpectedthrow (UserPhrase _ _ _ _ _ _ _ _ _ _ _ unexpectedthrow _ ) = unexpectedthrow

takeCityNames :: UserPhrase -> (Text,Text)
takeCityNames (UserPhrase _ _ _ _ _ _ _ _ _ _ _ _ [(cityNameInLanguage,cityNameForServer)] ) = (cityNameInLanguage,cityNameForServer)
