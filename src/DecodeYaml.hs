module DecodeYaml where

import qualified Data.ByteString   as B
import           Data.Text
import qualified Data.Text.IO      as TIO
import qualified Data.Yaml         as Y
import           Types.UserPhrases

parseYaml :: B.ByteString -> Maybe UserPhrase
parseYaml rawYAML = do
    let result = Y.decodeEither' rawYAML :: Either Y.ParseException UserPhrase
    case result of
        Right ok -> Just ok
        Left err -> error "asdasd"

choosLang :: Either Y.ParseException UserPhrase -> Text
choosLang (Right (UserPhrase lang _ _ _ _ _ _ _ _ _ _ _)) = lang
choosLang (Left exp1 ) = error "asd1213asdasd"

choosDate :: Either Y.ParseException UserPhrase -> Text
choosDate (Right (UserPhrase _ date _ _ _ _ _ _ _ _ _ _)) = date
choosDate (Left exp2 ) = error "asd1213asdasd"

choosCity :: Either Y.ParseException UserPhrase -> Text
choosCity (Right (UserPhrase _ _ city _ _ _ _ _ _ _ _ _)) = city
choosCity (Left exp3 ) = error "asd1213asdasd"

forecastInfo :: Either Y.ParseException UserPhrase -> Text
forecastInfo (Right (UserPhrase _ _ _ forecast _ _ _ _ _ _ _ _)) = forecast
forecastInfo (Left exp4 ) = error "asd1213asdasd"

on' :: Either Y.ParseException UserPhrase -> Text
on' (Right (UserPhrase _ _ _ _ on _ _ _ _ _ _ _)) = on
on' (Left exp5 )                                  = error "asd1213asdasd"

tempInfo :: Either Y.ParseException UserPhrase -> Text
tempInfo (Right (UserPhrase _ _ _ _ _ temp _ _ _ _ _ _)) = temp
tempInfo (Left exp6 ) = error "asd1213asdasd"

pressInfo :: Either Y.ParseException UserPhrase -> Text
pressInfo (Right (UserPhrase _ _ _ _ _ _ pressure _ _ _ _ _)) = pressure
pressInfo (Left exp7 ) = error "asd1213asdasd"

pressDes :: Either Y.ParseException UserPhrase -> Text
pressDes (Right (UserPhrase _ _ _ _ _ _ _ press _ _ _ _)) = press
pressDes (Left exp8 ) = error "asd1213asdasd"

infoAboutHumidity :: Either Y.ParseException UserPhrase -> Text
infoAboutHumidity (Right (UserPhrase _ _ _ _ _ _ _ _ humidity _ _ _)) = humidity
infoAboutHumidity (Left exp9 ) = error "asd1213asdasd"

messErrorDate :: Either Y.ParseException UserPhrase -> Text
messErrorDate (Right (UserPhrase _ _ _ _ _ _ _ _ _ errorDate _ _)) = errorDate
messErrorDate (Left exp10 ) = error "asd1213asdasd"

messErrorCity :: Either Y.ParseException UserPhrase -> Text
messErrorCity (Right (UserPhrase _ _ _ _ _ _ _ _ _ _ errorCity _)) = errorCity
messErrorCity (Left exp11 ) = error "asd1213asdasd"

messUnexpectedError :: Either Y.ParseException UserPhrase -> Text
messUnexpectedError (Right (UserPhrase _ _ _ _ _ _ _ _ _ _ _ unexpectedError)) = unexpectedError
messUnexpectedError (Left exp12 ) = error ""
