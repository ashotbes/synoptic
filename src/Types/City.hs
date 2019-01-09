module Types.City where

-- Список городов

data City
   = Aragatsotn
   | Ararat
   | Armavir
   | Dilijan
   | Gegharkunik
   | Gyumri
   | Kotayk
   | Shirak
   | Syunik
   | Vanadzor
   | Yerevan
   deriving (Read, Enum, Eq, Ord, Show)
