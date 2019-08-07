-- recursive maximum of array

maximum' :: Ord a => [a] -> a
maximum' [] = error "Empty list has no maximum."
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)