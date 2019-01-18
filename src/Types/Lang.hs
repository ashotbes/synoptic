module Types.Lang where

data MessageForUser
   = MessageChooseForecastDate
   | MessageChooseForecastCity
   | MessageForecast
   | On
   | MessageAboutTemperature
   | MessageAboutPressure
   | PressureDesignation
   | Humidity
   | MessageErrorWrongDate
   | MessageErrorWrongCity
   | MessageUnexpectedError
   deriving (Show)

data Language = En | Ru | Am
              deriving (Show)
