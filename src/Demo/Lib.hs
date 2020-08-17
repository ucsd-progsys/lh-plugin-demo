module Demo.Lib where

{-@ type Pos = {v:Int | 0 < v} @-}

{-@ incr :: Pos -> Pos @-}
incr :: Int -> Int
incr x = x + 1

{-@ inline add @-}
add :: Int -> Int -> Int
add x y = x + y

{-@ measure f :: String @-}
