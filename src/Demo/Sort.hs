module Demo.Sort where

-- Ordered Lists ---------------------------------------------------------------------------
{-@ type OrdList a = [a]<{\x v -> x <= v}> @-}

{-@ ups :: OrdList Int @-}
ups :: [Int]
ups = [1, 2, 3, 4, 5]

-- Insertion Sort --------------------------------------------------------------------------

-- insertSort :: (Ord a) => [a] -> [a]
-- insertSort = foldr insert []

-- insert :: (Ord a) => a -> [a] -> [a]










-- Merge Sort (optional?) ------------------------------------------------------------------

{-
mergeSort :: (Ord a) => [a] -> [a]
mergeSort []  = []
mergeSort [x] = [x]
mergeSort xs  = merge (mergeSort ys) (mergeSort zs) 
  where 
    (ys, zs)  = split xs

-- A type describing two `Halves` of a list `Xs`

-- Each `Half` is strictly smaller when list has 2 or more elts

-- `split` breaks its list into two `Halves` 
split :: [a] -> ([a], [a])
split []       = ([], [])
split [x]      = ([x], [])
split (x:y:zs) = (x:xs', y:ys') 
  where 
    (xs', ys') = split zs 

merge :: (Ord a) => [a] -> [a] -> [a]
merge (x:xs) (y:ys)
  | x <= y          = x : merge xs (y:ys)
  | otherwise       = y : merge (x:xs) ys
merge xs []         = xs
merge [] ys         = ys

-}