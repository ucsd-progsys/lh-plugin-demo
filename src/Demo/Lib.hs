module Demo.Lib where

{-@ incr :: Nat -> Nat @-}
incr :: Int -> Int 
incr x = x - 1

{-@ zincr :: Nat -> Nat @-}
zincr :: Int -> Int 
zincr x = 
    let tmp = 2 in 
    x - tmp


-- foo :: Int -> Int
-- foo x = []
-- • 