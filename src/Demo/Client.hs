module Algebra where

import qualified Numeric.LinearAlgebra as NLA

import qualified Data.Vector.Storable as DVS

{-@ measure slen :: Data.Vector.Storable.Vector t -> Int @-}



------------------------------------------------------------------
------------------------------------------------------------------
{-@ type NonNegSt t = {v:(Data.Vector.Storable.Vector t) | slen v >= 0} @-}

{-@ type NonNegInt = {v:Int | v >= 0} @-}

{-@ assume Data.Vector.Storable.length :: x:_ -> {n:Nat | n = slen x} @-}

{-@ assume Data.Vector.Storable.unsafeIndex :: x:(NonNegSt t) -> {i:Nat | i <= slen x} -> t @-}

{-@ assume (<.>) :: x:_ -> {i:(NonNegSt t) | (slen i) == (slen x)} -> t @-}

{-@ measure cols :: Matrix t -> Int @-}

{-@ assume (#>) :: xs:_ -> {ys:NonNegSt t | (slen ys) == (cols xs)} -> rs:_ @-}

{-@ assume (><) :: Storable a => x:Nat -> y:Nat -> xs:[a] -> {m:Matrix a | cols m == y} @-}

{-@ assume Data.Vector.Storable.fromList :: xs:_ -> {v:_ | slen v == len xs } @-}

test1 :: Char
test1 = flip DVS.unsafeIndex 1 $ DVS.fromList ['1','2']

test2 :: NLA.Matrix Double
test2 = (1 NLA.>< (1)) [1..] 

test3 :: Double
test3 = DVS.fromList [1] NLA.<.> DVS.fromList [2]

test4 :: DVS.Vector Double
test4 = (5 NLA.>< 3) [10,20,30] NLA.#> DVS.fromList [10,20,30]
