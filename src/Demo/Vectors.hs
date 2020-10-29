{-@ LIQUID "--short-names" @-}

module Demo.Vectors where

import Prelude hiding (length)
import Data.Vector hiding (sum)

-- vectorSum --------------------------------------------------------------
-- vectorSum :: Vector Double -> Double











-- dotProduct --------------------------------------------------------------
-- dotProduct :: Vector Double -> Vector Double -> Maybe Double
  





























































{-@ assume GHC.Enum.enumFromTo :: (Enum a) => lo:a -> hi:a -> [{v:a | lo <= v && v <= hi}] @-}