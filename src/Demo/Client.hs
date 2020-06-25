module Demo.Client where

import Demo.Lib

bump :: Int -> Int
bump n 
  | 0 <= n    = incr n
  | otherwise = 0

{-@ ignore thisIsUnsafe @-} -- delete this to see an error
thisIsUnsafe :: Int -> Int
thisIsUnsafe x = incr x