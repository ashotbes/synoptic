{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

--import           AskWeatherFromServer  (askWeather)
--import           CheckDateAndCity      (getCityFromUser, getDateFromUser,
--                                        reportAboutProblem)
--import           AskWeatherFromServer  (askWeather)
--import           CheckDateAndCity      (getCityFromUser, getDateFromUser,
--                                        reportAboutProblem)

--import           GHC.List              as L
--import           Data.Maybe
--import qualified Data.ByteString       as B
--import           Data.List             (filter, unzip)
--import           Data.Text             as T
--import           Data.Text.IO          as TIO
--import           Data.Time.Clock
--import qualified Data.Yaml             as Y
--import qualified Data.ByteString       as B
import qualified Data.List             as L
import qualified Data.Text             as T
import qualified Data.Text.IO          as TIO
--import           Data.Time.Clock
--import qualified Data.Yaml             as Y
import           System.Directory
import           System.Exit
import           System.FilePath.Posix
--import           Types.UserPhrases     (UserPhrase (..))
--import           Types.UserPhrases     (UserPhrase (..))

--import           DecodeYaml
--import           PrepareAnswer         (prepareAnswer)

tupleToList :: [(a,a)] -> [a]
tupleToList ((a,b):xs) = a : b : tupleToList xs
tupleToList _          = []

main :: IO ()
main = do
  currentDirectory <- getCurrentDirectory
  let langDirectory = currentDirectory </> "i18n"
  allLangFiles <- listDirectory langDirectory >>= \case
      [] -> die $ "Sorry, but I cannot continue without language support. " ++
                  "Please make sure the directory " ++ langDirectory ++ " exists."
      allLangFiles -> return allLangFiles
  let pureNamesOfLangs = Prelude.map takeBaseName allLangFiles
  Prelude.putStrLn $ "Please choose your language: " ++ L.intercalate ", " pureNamesOfLangs
  language <- TIO.getLine
  let preparedLanguage = T.toLower language
      correspondingLangFile = L.find (\langFile -> preparedLanguage == T.pack (takeBaseName langFile)) allLangFiles >>= \case
          correspondingLangFile1 -> return correspondingLangFile1
  print preparedLanguage
  print correspondingLangFile1



      {-
  let langFile    = currentDir </> "i18n" </> "ru.yaml"
      langFolder  = currentDir </> "i18n"
  con <- B.readFile $ langFolder </> langFile
@@ -70,3 +85,4 @@ main = do
                  let answer = prepareAnswer response correctDate correctCity phrase
                  TIO.putStrLn answer
                  else TIO.putStrLn "Please select one of the suggested languages!"
                  -}
