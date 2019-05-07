module AskWeatherFromServer where

import           Data.ByteString.Lazy (ByteString)
import           Data.Text
import           Network.HTTP.Client  (Response, defaultManagerSettings,
                                       httpLbs, newManager, parseRequest,
                                       responseBody)

-- Отправляем запрос на сервер и получаем ответ

askWeather :: Text -> IO (Response ByteString)
askWeather cityFromUser = do
    manager <- newManager defaultManagerSettings
    request <- parseRequest $ "http://api.openweathermap.org/data/2.5/forecast?q="
                              <> unpack cityFromUser
                              <> ",am&mode=json&appid=9e23b1eea9c1da6e75d81b6271c0379c"
    httpLbs request manager

rawResponse :: Response ByteString -> ByteString
rawResponse = responseBody
