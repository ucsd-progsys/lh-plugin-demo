module Demo.Bug where

{-@ foo :: {v:Int | v > 0 && v > 5 && v < 10 } -> Int @-}
foo :: Int -> Int
foo x = x + 1

{-@ ignore bar @-} 
bar = foo 2
