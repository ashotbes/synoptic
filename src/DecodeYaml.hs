{-# LANGUAGE OverloadedStrings #-}

module DecodeYaml where

--import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BSL
--import qualified Data.Yaml      as Y
--import qualified Data.Text.IO   as TIO
import           Types.UserPhrases
import           Data.Text
import           Data.Aeson as A

parseYaml :: BSL.ByteString -> Maybe UserPhrase
parseYaml rawYAML = do
    let result = A.decode rawYAML :: Maybe UserPhrase
    case result of
          Just ok -> Just ok
          Nothing -> error "asdasd"

choosLang :: Maybe UserPhrase -> Text
choosLang (Just (UserPhrase lang _ _ _ _ _ _ _ _ _ _ _)) = lang
choosLang Nothing =  "asd1213asdasd"

choosDate :: Maybe UserPhrase -> Text
choosDate (Just (UserPhrase _ date _ _ _ _ _ _ _ _ _ _)) = date
choosDate Nothing =  "asd1213asdasd"

choosCity :: Maybe UserPhrase -> Text
choosCity (Just (UserPhrase _ _ city _ _ _ _ _ _ _ _ _)) = city
choosCity Nothing =  "asd1213asdasd"

forecastInfo :: Maybe UserPhrase -> Text
forecastInfo (Just (UserPhrase _ _ _ forecast _ _ _ _ _ _ _ _)) = forecast
forecastInfo Nothing = "asd1213asdasd"

on' :: Maybe UserPhrase -> Text
on' (Just (UserPhrase _ _ _ _ on1 _ _ _ _ _ _ _)) = on1
on' Nothing =  "asd1213asdasd"

tempInfo :: Maybe UserPhrase -> Text
tempInfo (Just (UserPhrase _ _ _ _ _ temp _ _ _ _ _ _)) = temp
tempInfo Nothing =  "asd1213asdasd"

pressInfo :: Maybe UserPhrase -> Text
pressInfo (Just (UserPhrase _ _ _ _ _ _ pressure _ _ _ _ _)) = pressure
pressInfo Nothing =  "asd1213asdasd"

pressDes :: Maybe UserPhrase -> Text
pressDes (Just (UserPhrase _ _ _ _ _ _ _ press _ _ _ _)) = press
pressDes Nothing  =  "asd1213asdasd"

infoAboutHumidity :: Maybe UserPhrase -> Text
infoAboutHumidity (Just (UserPhrase _ _ _ _ _ _ _ _ humidity' _ _ _)) = humidity'
infoAboutHumidity Nothing =  "asd1213asdasd"

messErrorDate :: Maybe UserPhrase -> Text
messErrorDate (Just (UserPhrase _ _ _ _ _ _ _ _ _ errorDate _ _)) = errorDate
messErrorDate Nothing =  "asd1213asdasd"

messErrorCity :: Maybe UserPhrase -> Text
messErrorCity (Just (UserPhrase _ _ _ _ _ _ _ _ _ _ errorCity _)) = errorCity
messErrorCity Nothing = error "asd1213asdasd"

messUnexpectedError :: Maybe UserPhrase -> Text
messUnexpectedError (Just (UserPhrase _ _ _ _ _ _ _ _ _ _ _ unexpectedError)) = unexpectedError
messUnexpectedError Nothing  =  "asd1213asdasd"
