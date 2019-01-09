module Types.Lang where

data MessageForUser
   = MessageChooseForecastDate
   | MessageChooseForecastCity
   | MessageForecast
   | MessageErrorWrongDate
   | MessageErrorWrongCity
   | MessageUnexpectedError
   deriving (Show)

data Language = En | Ru | Am
              deriving (Show)
