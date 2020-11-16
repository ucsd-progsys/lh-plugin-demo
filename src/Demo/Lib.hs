module Demo.Lib where

{-@ LIQUID "--diff" @-}

data Thing = Thing Int

{-@ measure thingVal @-}
thingVal :: Thing -> Int
thingVal (Thing n) = n

data Box = Box Thing 

{-@ data Box = Box { bVal :: {v:Thing | 0 <= thingVal v} } @-}

{-@ mkBox :: Nat -> Box @-}
mkBox :: Int -> Box
mkBox n = Box (Thing (n - 1))
