-- Proving theorems about simple key-value maps

{-@ LIQUID "--reflection" @-}
{-@ LIQUID "--ple"        @-}
{-# LANGUAGE PartialTypeSignatures #-}

module Demo.Maps where

import Prelude hiding (sum)
import Language.Haskell.Liquid.ProofCombinators





-- sum numbers from 1 .. n ------------------------------------------------------

{-@ reflect sum @-}
sum :: Int -> Int 
sum n 
  | n <= 0    = 0
  | otherwise = n + sum (n-1)

-- >>> sum 4
-- 10
--

-- Make the type checker "run" it at compile time!
{-@ sum4 :: () -> { sum 4 == 10 } @-}
sum4 :: () -> ()
sum4 () = () 

-- A theorem about `sum`: forall n. 2 * sum (n) = n * (n + 1) -----------------

-- thm_sum :: n:Nat -> { 2 * (sum n) == n * (n + 1) }
-- thm_sum :: Int -> Int  
























-- A Map datatype (simple "association list") ---------------------------------

data Map k v 
  = Emp 
  | Bind k v (Map k v)
    deriving (Show)

-- get key from map ---------------------------------------------------------- 

{-@ reflect get @-}
get :: (Eq k) => k -> Map k v -> Maybe v
get key (Bind k v m) 
  | key == k  = Just v 
  | otherwise = get key m 
get key Emp   = Nothing

-- set key to value in map --------------------------------------------------- 

{-@ reflect set @-}
set :: k -> v -> Map k v -> Map k v
set key val m = Bind key val m

-- tests before proofs! ------------------------------------------------------

-- >>> get "cat" (set "cat" 10 (set "dog" 20 Emp))
-- Just 10
--
-- >>> get "dog" (set "cat" 10 (set "dog" 20 Emp))
-- Just 20

-- >>> get "horse" (set "cat" 10 (set "dog" 20 Emp))
-- Nothing
--

------------------------------------------------------------------------------

-- forall key, val, m. get key (set key val m) = val

{-@ thm_get_eq :: key:_ -> val:_ -> m:_ -> 
      { get key (set key val m) = Just val } 
  @-}
thm_get_eq :: (Eq k) => k -> v -> Map k v -> ()
thm_get_eq key val (Bind k v m)
  | key == k           = ()
  | otherwise          = thm_get_eq key val m
thm_get_eq key val Emp = ()

{-@ thm_get_neq :: key:_ -> val:_ -> key':{key' /= key} -> m:_ -> 
      { get key' (set key val m) = get key' m } 
  @-}
thm_get_neq :: (Eq k) => k -> v -> k -> Map k v -> ()
thm_get_neq key val key' (Bind k v m)
  | key == k           = ()
  | otherwise          = thm_get_neq key val key' m
thm_get_neq _ _ _ Emp  = ()


