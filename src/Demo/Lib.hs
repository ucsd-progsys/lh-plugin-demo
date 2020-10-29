module Demo.Lib where

{-@ type Pos = {v:Int | 0 < v} @-}

{-@ incr :: Pos -> Pos @-}
incr :: Int -> Int
incr x = x + 1

{-@ measure myLen @-}
myLen :: [a] -> Int
myLen [] = 0
myLen (_x:xs) = 1 + myLen xs

{-@ data Eg [egLen] @-}
data Eg = Eg String

{-@ measure egLen @-}
egLen :: Eg -> Int
egLen (Eg xs) = myLen xs
