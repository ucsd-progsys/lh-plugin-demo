
module Demo.Client where

import Demo.Lib

{-@ reflect bob @-}
bob :: Int -> Int
bob k = add 10 k