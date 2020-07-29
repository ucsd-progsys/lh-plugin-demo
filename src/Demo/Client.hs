module Demo.Client where

import Demo.Lib

bump n = if n > 0 then incr n else 0

{-@ ignore thisIsUnsafe @-} -- delete this to see an error
thisIsUnsafe :: Int -> Int
thisIsUnsafe x = incr x
