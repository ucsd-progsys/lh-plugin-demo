module Demo.Client where

import Demo.Lib

{-@ foo :: _ -> Nat @-}
foo :: Int -> Int
foo n = if n < 0 then 0 else incr n
