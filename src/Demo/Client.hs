{-@ LIQUID "--reflection" @-}
{-@ LIQUID "--ple"        @-}

module Demo.Client where

import Demo.Lib
import Language.Haskell.Liquid.ProofCombinators

bump :: Int -> Int
bump n = if n > 0 then incr n else 0

{-@ reflect fldl @-}
fldl :: (a -> b -> a) -> a -> [b] -> a
fldl f z [] = z
fldl f z (x:xs) = fldl f (f z x) xs

-- {-@ flipcons :: xs:_ -> _ -> {ys:_ | len xs + 1 == len ys} @-}

{-@ reflect flipcons @-}
flipcons :: [a] -> a -> [a]
flipcons xs x = x:xs

{-@ reflect rev @-}
rev :: [a] -> [a] 
rev xs = fldl flipcons [] xs

{-@ lemma :: acc:_ -> xs:_ -> {len (fldl flipcons acc xs) == len acc + len xs} @-}
lemma :: [a] -> [a] -> ()
lemma acc []     = ()
lemma acc (x:xs) = lemma (x:acc) xs

{-@ thm :: xs:_ -> { len (rev xs) = len xs } @-}
thm :: [a] -> ()
thm xs = lemma [] xs

