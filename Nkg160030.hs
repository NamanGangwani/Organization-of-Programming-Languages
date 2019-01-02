module Nkg160030 where

filter' :: (cond -> Bool) -> [cond] -> [cond] -- Condition should be a boolean
filter' cond lst = if (null lst)
                 then [] -- empty list if given list is null
                 else do
                  if (cond (head lst)) -- if the first element meets the given criteria
                  then
                   ([(head lst)] ++ (filter' cond (tail lst))) -- include element just checked and continue filtering rest of the list
                  else
                   (filter' cond (tail lst)) -- don't include element just checked, continue filtering rest of the list