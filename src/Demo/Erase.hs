{-# OPTIONS_GHC -fplugin=LiquidHaskell #-}
{-@ LIQUID "--reflection" @-}
{-@ LIQUID "--ple"        @-}

module Demo.Erase where

import Prelude hiding (id, sum)
import Language.Haskell.Liquid.ProofCombinators
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Vector

data List = Emp | Cons Int List

{-@ reflect isSorted @-}
isSorted :: List -> Bool
isSorted Emp = True
isSorted (Cons x xs) = isSorted xs && case xs of
  Emp -> True
  Cons x1 xs1 -> x <= x1

{-@ reflect insert @-}
{-@ insert :: x:Int -> {xs:List | isSorted xs} -> {xs:List | isSorted xs} @-}
insert :: Int -> List -> List
insert x Emp     = Cons x Emp
insert x (Cons y ys)
  | x <= y        = Cons x (Cons y ys)
  | otherwise     = Cons y (insert x ys) `withProof` lem_ins y x ys

{-@ lem_ins :: y:Int -> {x:Int | y < x} -> {ys:List | isSorted (Cons y ys)} -> {isSorted (Cons y (insert x ys))} @-}
lem_ins :: Int -> Int -> List -> Bool
lem_ins y x Emp = True
lem_ins y x (Cons y1 ys) = if y1 < x then lem_ins y1 x ys else True

-- This function is here only to check that Liquid Haskell
-- is picking up assumptions from liquid-vector.
{-@ fail vectorTest @-}
vectorTest :: Vector Int -> Int
vectorTest v = v Data.Vector.! 10
