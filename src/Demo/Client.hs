module Demo.Client where

import Demo.Lib

bump :: Int -> Int
bump n = incr n

{-@ ignore thisIsUnsafe @-} -- delete this to see an error
thisIsUnsafe :: Int -> Int
thisIsUnsafe x = incr x
