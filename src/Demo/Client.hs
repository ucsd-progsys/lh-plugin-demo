module Demo.Client where

{-@ LIQUID "--diff" @-}

{-@ inc :: Nat -> Nat @-}
inc :: Int -> Int
inc x = x - 1
