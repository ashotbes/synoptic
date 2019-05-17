module AskWeatherFromServer where

import           Data.ByteString.Lazy ( ByteString )
import           Data.Text            ( Text, unpack )
import           Network.HTTP.Client  ( Response, defaultManagerSettings,
                                        httpLbs, newManager, responseBody
                                      , parseUrlThrow )

-- Отправляем запрос на сервер и получаем ответ

askWeather :: Text -> IO (Response ByteString)
askWeather cityFromUser = do
    manager <- newManager defaultManagerSettings
    request <- parseUrlThrow $ "http://api.openweathermap.org/data/2.5/forecast?q="
                              <> unpack cityFromUser
                              <> ",am&mode=json&appid=9e23b1eea9c1da6e75d81b6271c0379c"
    httpLbs request manager

rawResponse :: Response ByteString -> ByteString
rawResponse = responseBody
