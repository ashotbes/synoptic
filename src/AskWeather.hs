module AskWeather where

import           Data.ByteString.Lazy (ByteString)
import           Data.Time.Clock      (UTCTime)
import           Network.HTTP.Client  (Response, defaultManagerSettings,
                                       httpLbs, newManager, parseRequest)

import           Types.City

-- Отправляем запрос на сервер и получаем ответ

askWeather :: (UTCTime,City) -> IO (Response ByteString)
askWeather (_, userCity) = do
    manager <- newManager defaultManagerSettings
    request <- parseRequest $ "http://api.openweathermap.org/data/2.5/forecast?q=" ++ show userCity ++ ",am&mode=json&appid=9e23b1eea9c1da6e75d81b6271c0379c"
    httpLbs request manager
