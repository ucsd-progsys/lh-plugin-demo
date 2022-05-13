module Demo.Lib where

import Data.Set

{-@ type Pos = {v:Int | 0 < v} @-}

{-@ incr :: Pos -> Pos @-}
incr :: Int -> Int
incr x = x + 1


{-@ measure elts @-}
elts        :: (Ord a) => [a] -> Set a
elts []     = empty
elts (x:xs) = singleton x `union` elts xs

{-@ rev :: xs:_ -> {v:_ | elts v == elts xs} @-}
rev :: [a] -> [a]
rev = go [] 
  where
    {-@ go :: acc:_ -> xs:_ -> {v:_ | elts v == union (elts acc) (elts xs)} @-}
    go acc []     = acc
    go acc (x:xs) = go (x:acc) xs
