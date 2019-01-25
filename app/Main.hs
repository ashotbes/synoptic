module Main where

import           Data.Text.IO as TIO

import           AskWeather      (askWeather)
import           GettingUserDate (getLanguageFromUser, getUserData,
                                  reportAboutProblem)
import           PrepareAnswer   (prepareAnswer)

main :: IO ()
main = do
    lang <- getLanguageFromUser
    userData <- getUserData lang
    case userData of
        Left problem -> reportAboutProblem lang problem
        Right (date,city) -> do
            response <- askWeather (date, city)
            let answer = prepareAnswer lang response date city
            TIO.putStrLn answer
