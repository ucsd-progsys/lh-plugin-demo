{-# OPTIONS_GHC -fplugin=LiquidHaskell #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE LinearTypes   #-}

module Demo.Client (rev, toLinear, toLinear3) where

{-@ LIQUID "--reflection"  @-}

{-    LIQUID "--extensionality" @-}

import qualified Unsafe.Linear as Unsafe

import Prelude hiding (sum)
import Language.Haskell.Liquid.Equational

{-    @ assume toLinear :: f:_ -> { g:_ | f == g} @-}

{-@ assume toLinear :: f:(a -> b) -> x:a -> { v:b | v == f x } @-}
toLinear :: (a -> b) -> (a %1-> b)
toLinear f = Unsafe.toLinear f

{-@ assume toLinear3 :: f:_ -> x:_ -> y:_ -> z:_ -> { v:d | v == f x y z } @-}
toLinear3 :: (a -> b -> c -> d) -> (a %1-> b -> c -> d)
toLinear3 f = Unsafe.toLinear3 f





{-@ qualif LenSum(x1:a, x2:b): (goo x1) = 289  @-}
{-@ qualif LenSum(x1:a, x2:b): (goo x1) = (goo x2)  @-}
{-@ qualif LenSum(x1:a, x2:b, x3:c): (goo x1) = (goo x2) + (goo x3) @-}

{-@ measure goo @-}
{-@ goo :: [a] -> Nat @-}
goo :: [a] -> Int
goo [] = 0
goo (x:xs) = 1 + goo xs

{-@ rev :: xs:_ -> {v:_ | goo v == goo xs } @-}
rev :: [a] -> [a]
rev xs = revApp [] xs

{-@ revApp :: acc:_ -> ys:_ -> {v:_ | goo v = goo acc + goo ys} @-}
revApp :: [a] -> [a] -> [a]
revApp acc [] = acc
revApp acc (y:ys) = revApp (y:acc) ys

{-@ reflect sum @-}
{-@ sum :: Nat -> Int @-}
sum :: Int -> Int
sum 0 = 0
sum n = n + sum (n-1)

{-@ sum_lemma :: n:Nat -> { 2 * sum n == n * (n + 1) } @-}
sum_lemma :: Int -> ()
sum_lemma 0 = sum 0 
           ==. 0 
          *** QED
sum_lemma n = 2 * sum n
          ==. 2 * (n + sum (n-1))
          ==. 2 * n  + 2 * sum (n-1)
            ? sum_lemma (n-1)
          ==. 2 * n  + (n - 1) * n 
          ==. n * (n + 1)
          *** QED

{-@ sum_nat :: n:Nat -> { n <= sum n } @-}
sum_nat :: Int -> ()
sum_nat 0 =  0 
        <=. sum 0 
        *** QED 
sum_nat n = n
          ? sum_nat (n - 1)
        <=. n + sum (n - 1)
        <=. sum n
        *** QED


-- A "proof combinator" that lets us build up chained "equational-style" proofs

infixl 3 <=.
{-@ (<=.) :: x:a -> y:{a | x <= y} -> {v:a | v == y} @-}
(<=.) :: a -> a -> a 
_ <=. y = y 
{-# INLINE (<=.) #-} 

------------------
--


-- -- {-@ ple sum_lemma @-}
-- -- {-@ sum_lemma :: n:Nat -> { 2 * sum n == n * (n + 1) } @-}
-- -- sum_lemma :: Int -> ()
-- -- sum_lemma 0 = ()
-- -- sum_lemma n = sum_lemma (n-1)

-- -- {-@ reflect fib @-}
-- -- fib :: Int -> Int
-- -- fib n = if n <= 1 then 1 else fib (n-1) + fib (n-2)

-- -- {-@ fib3_lemma :: () -> { fib 5 == 8 } @-}
-- -- fib3_lemma :: () -> ()
-- -- fib3_lemma () = ()

-- -- {-@ fib_mono_lemma :: n:{Int | 2 <= n } -> { n <= fib n} / [n] @-}
-- -- fib_mono_lemma :: Int -> ()
-- -- fib_mono_lemma 2 = ()
-- -- fib_mono_lemma 3 = ()
-- -- fib_mono_lemma n = () ? fib_mono_lemma (n-1)
-- --                       ? fib_mono_lemma (n-2)

-- -------------------------------------------------------------------------------

-- data Binary
--   = B0 Binary
--   | B1 Binary
--   | BEnd

-- data DecList t a where
--   DNil  :: DecList t a
--   DCons :: t a -> DecList t a -> DecList t a

-- {-@ measure dsize @-}
-- {-@ dsize :: DecList t a -> Nat @-}
-- dsize :: DecList t a -> Int
-- dsize DNil = 0
-- dsize (DCons _ d) = 1 + dsize d

-- data Tree a where
--   MkTree :: a -> DecList Tree a -> Tree a

-- -- {- reflect isTreeK @-}
-- -- isTreeK :: Int -> Tree a -> Bool
-- -- isTreeK k (MkTree _ DNil) = True
-- -- isTreeK k (MkTree _ (DCons t d)) = isTreeK k t && isDlistK k d

-- -- isDlistK :: Int -> DecList Tree a -> Bool
-- -- isDlistK k DNil = True
-- -- isDlistK k (DCons t d) = isTreeK k t && isDlistK (k-1) d

-- data Forest a where
--     FEnd :: Forest a
--     F0   :: Forest a -> Forest a
--     F1   :: Tree a -> Forest a -> Forest a

-- {-@ measure pot @-}
-- {-@ pot :: Forest a -> Nat @-}
-- pot :: Forest a -> Int
-- pot FEnd        = 0
-- pot (F0 rest)   = pot rest
-- pot (F1 _ rest) = 1 + pot rest


-- {-@ reflect mergeTree @-}
-- mergeTree :: Ord a => Tree a -> Tree a -> Tree a
-- mergeTree l@(MkTree lr lc) r@(MkTree rr rc)
--   | lr <= rr = MkTree lr (DCons r lc)
--   | otherwise = MkTree rr (DCons l rc)

-- {-@ reflect insertTree @-}
-- insertTree :: Ord a => Tree a -> Forest a -> Forest a
-- insertTree t FEnd = F1 t FEnd
-- insertTree t (F0 f) = F1 t f
-- insertTree t (F1 t' f) = F0 (insertTree (mergeTree t t') f)

-- {-@ reflect insertTreeT @-}
-- insertTreeT :: Ord a => Tree a -> Forest a -> Int
-- insertTreeT _ FEnd = 1
-- insertTreeT _ (F0 _) = 1
-- insertTreeT t (F1 t' f) = 1 + insertTreeT (mergeTree t t') f

-- {-@ insertTreeAmortized :: t:_ -> f:_ -> { insertTreeT t f + pot (insertTree t f) - pot f <= 2 } @-}
-- insertTreeAmortized :: Ord a => Tree a -> Forest a -> Proof
-- insertTreeAmortized t FEnd
--   = insertTreeT t FEnd + pot (insertTree t FEnd) - pot FEnd
--   ==. 1 + pot (F1 t FEnd) - 0
--   ==. 1 + 1 + pot FEnd - 0
--   ==. 2
--   *** QED
-- insertTreeAmortized t (F0 rest)
--   = insertTreeT t (F0 rest) + pot (insertTree t (F0 rest)) - pot (F0 rest)
--   ==. 1 + pot (F1 t rest) - pot rest
--   ==. 1 + 1 + pot rest - pot rest
--   ==. 2
--   *** QED
-- insertTreeAmortized t (F1 t' rest)
--   = insertTreeT t (F1 t' rest) + pot (insertTree t (F1 t' rest)) - pot (F1 t' rest)
--   ==. 1 + insertTreeT (mergeTree t t') rest + pot (F0 (insertTree (mergeTree t t') rest)) - (1 + pot rest)
--   ==. 1 + insertTreeT (mergeTree t t') rest + pot (insertTree (mergeTree t t') rest) - 1 - pot rest
--   ==. insertTreeT (mergeTree t t') rest + pot (insertTree (mergeTree t t') rest) - pot rest
--     ? insertTreeAmortized (mergeTree t t') rest
--   *** QED
