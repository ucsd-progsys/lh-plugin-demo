{-@ LIQUID "--short-names" @-}

module Demo.Total where
import Prelude hiding (head)

--  head ----------------------------------------------------------------------
-- head :: [a] -> a

{-@ head :: NonEmptyList a -> a @-}
head :: [a] -> a 
head (x:xs) = x
head []     = error "oops the list is empty!" 

{-@ type NonEmptyList thing = {v:[thing] | listSize v > 0} @-} 

-- non-empty lists ------------------------------------------------------------

{-@ type Nat = {v:Int| 0 <= v} @-}


{-@ measure listSize @-}

{-@ listSize :: [a] -> Nat @-}
listSize :: [a] -> Int
listSize [] = 0
listSize (x:xs) = 1 + listSize xs

-- average ------------------------------------------------------------------

average :: [Int] -> Maybe Int
average xs 
  | n >  0    = Just (sum xs `div` n)
  | otherwise = Nothing
  where 
    n         = listSize xs






--  unstutter -----------------------------------------------------------------

-- >>> unstutter "ssssllllythhherrrrrriiiinnnnnn"
-- "slytherin"
--

-- ['c', 'c', 'a', 't', 't', 't'] 
-- ['c', 'c'], ['a'], ['t', 't', 't']
-- ['c', 'a', 't']

unstutter :: (Eq a) => [a] -> [a]
unstutter xs = map head (group xs)

{-@ ex1 :: [NonEmptyList Int] @-}
ex1 :: [[Int]]
ex1 = [[1,2,3], [3,4,5]]



{-@ group :: (Eq a) => [a] -> [ NonEmptyList a ] @-}
group :: (Eq a) => [a] -> [[a]]
group []     = []
group (x:xs)   = (x:ys) : group zs
  where
      (ys, zs) = span (\z -> x == z) xs


-- >>> rev [1,2,3,4,5]
-- [5,4,3,2,1]
--

{-@ rev :: xs:_ -> {out:_ | listSize out = listSize xs} @-}
rev :: [a] -> [a]
rev xs = revHelper [] xs

-- rev []     = []
-- rev (x:xs) = rev xs ++ [x]

{-@ revHelper :: xs:_ -> ys:_ -> {out:_ | listSize out == listSize xs + listSize ys } @-}
revHelper :: [a] -> [a] -> [a]
revHelper stk [] = stk 
revHelper stk (x:xs) = revHelper (x:stk) xs




