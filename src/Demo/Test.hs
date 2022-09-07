-- {-# LANGUAGE RankNTypes #-}

{- LIQUID "--reflection" @-}

module Demo.Test where

{- reflect strict1 @-}
strict1 :: [a] -> Int
strict1 [] = 0
strict1 _ = 1

{-@ strict1Undefined :: { 12 > 1} @-}
strict1Undefined :: ()
strict1Undefined = const () (strict1 undefined)

{- 

-- import           Prelude                 hiding ( succ )
------------------------------------------------------------------------------------

data Peano = Z | S Peano deriving (Show)

toInt :: Peano -> Int
toInt Z     = 0
toInt (S n) = 1 + toInt n

toNat :: Int -> Peano
toNat n = if n <= 0 then Z else S (toNat (n - 1))

------------------------------------------------------------------------------------

-- BB version
data Peano' = BB { unBB :: forall a. a -> (a -> a) -> a }

zero = BB $ \onZ onS -> onZ
succ n = BB $ \onZ onS -> onS (unBB n onZ onS)

toInt' :: Peano' -> Int
toInt' n = unBB n 0 (+ 1)

three :: Peano'
three = succ (succ (succ zero))

toNat' :: Int -> Peano'
toNat' n = if n <= 0 then zero else succ (toNat' (n - 1))

-}

-- >>> toInt' (three

