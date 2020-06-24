module Demo.Client where

import Demo.Lib

{-@ incr' :: Nat -> Nat @-}
incr' :: Int -> Int 
incr' x = x + 1 

-- fails with ghcid
{-@ fails_with_ghcid :: Nat -> Nat @-}
fails_with_ghcid n = incr n

-- succeeds with ghcid
{-@ succeeds_with_ghcid :: Nat -> Nat @-}
succeeds_with_ghcid n = incr' n