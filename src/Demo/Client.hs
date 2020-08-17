{-@ LIQUID "--reflection" @-}

module Demo.Client where

import Demo.Lib

bump :: Int -> Int
bump n = if n > 0 then incr n else 0
