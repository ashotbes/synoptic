{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE MultiWayIf        #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

--import           AskWeatherFromServer  (askWeather)
--import           CheckDateAndCity      (getCityFromUser, getDateFromUser,
--                                        reportAboutProblem)

--import           GHC.List              as L
--import           Data.Maybe
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
    let pureNamesOfLangs = map takeBaseName allLangFiles
    putStrLn $ "Please choose your language: " ++ L.intercalate ", " pureNamesOfLangs
    language <- TIO.getLine
    let preparedLanguage = T.toLower language
        correspondingLangFile = L.find (\langFile -> preparedLanguage == T.pack (takeBaseName langFile)) allLangFiles
    print correspondingLangFile
    error ""

      {-
  let langFile    = currentDir </> "i18n" </> "ru.yaml"
      langFolder  = currentDir </> "i18n"
  con <- B.readFile $ langFolder </> langFile
  let parsedContent = Y.decodeThrow con :: Maybe UserPhrase
  case parsedContent of
    Nothing -> die "Sorry,we cant Decode this file!"
    Just phrase -> do
      let cityNames = (takeCityNames $ phrase) -- :: [Text]
          result' = [ let names = T.splitOn (",") twoNames
                          [nameForHuman, nameForServer] = Data.List.filter (not . T.null) names
                      in (nameForHuman, nameForServer)
                    | twoNames <- cityNames
                    ]
          (allNamesForHumans, _allNamesForServer) = unzip result'
      TIO.putStrLn (choosLang $ phrase )
      fileNames <- listDirectory langFolder
      print fileNames
      language <- TIO.getLine
      if (T.toLower $ language) == "ru"
        then do
          TIO.putStrLn (choosDate $ phrase)
          currentTime <- getCurrentTime
          dateFromUser <- Prelude.getLine
          let date = getDateFromUser currentTime dateFromUser phrase
          case date of
            Left problemWithDate -> TIO.putStrLn problemWithDate
            Right correctDate -> do
              TIO.putStrLn $ (choosCity $ phrase)
              TIO.putStrLn $ T.intercalate "," allNamesForHumans
              cityFromUser <- TIO.getLine
              let city = getCityFromUser cityNames cityFromUser
                  cityNamesForServer = Data.List.filter (\cityFromUser1 -> cityFromUser1 == (T.intercalate "," allNamesForHumans)) allNamesForHumans
              case city of
                Nothing -> reportAboutProblem phrase
                Just correctCity -> do
                  response <- askWeather (correctDate, Prelude.tail cityNamesForServer)
                  print $ (Prelude.tail cityNamesForServer)
                  let answer = prepareAnswer response correctDate correctCity phrase
                  TIO.putStrLn answer
                  else TIO.putStrLn "Please select one of the suggested languages!"
                  -}
