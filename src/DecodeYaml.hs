module DecodeYaml where

import qualified Data.Bystering.Lazy as BSL
import qualified Data.Yaml           as Y

parseYaml :: BSL.Bystering -> Maybe MessageForUser
parseYaml rawYAML = 
    let result = Y.decode rawYAML :: Maybe MessageForUser 
    case result of 
          Just ok -> Just ok 
          Nothing -> Nothing 

