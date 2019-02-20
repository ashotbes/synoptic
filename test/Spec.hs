yimport Test.Hspec
import Test.QuickCheck

import            Types.Lang
import            CheckDateAndCity

main :: IO ()
main = hspec $ do
  describe "Prelude.head" $ do
    it "returns the text" $ do
      reportAboutProblem Ru InvalidCity  `shouldBe` putStrLn "Please, enter a date for the forecast!"
