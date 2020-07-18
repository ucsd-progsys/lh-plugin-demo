module Demo.Lib where

{-@ type Pos = {v:Int | v > 0} @-}

{-@ incr :: Pos -> Pos @-}
incr :: Int -> Int
incr x = x - 1
