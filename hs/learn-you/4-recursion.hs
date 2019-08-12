-- recursive maximum of array

maximum' :: Ord a => [a] -> a
maximum' [] = error "Empty list has no maximum."
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

-- principle is to break problems down into more and more manageable ones, where eventually we have a base case
-- (some problem which is trivially solvable, e.g. max of [x] is x)

{-
Line by line:
    1. [] has no maximum
    2. [x] has maximum x
    3. (x:xs) has the maximum s.t. it is the largest number between x and the largest number (maximum) of xs
-}

replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' n x = x:(replicate' (n - 1) x)
-- with guards we could return [] upon any 0 or negative number

replicate'' :: Int -> a -> [a]
replicate'' n x
    | n <= 0 = []
    | otherwise = x : (replicate'' (n - 1) x)

take' :: Int -> [a] -> [a]
take' 0 xs     = []
take' n []     = []
take' n (x:xs) = x : (take' (n - 1) xs)
-- as before, could have guards to enforce for n <= 0, leaving them out here

reverse' :: [a] -> [a]
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a -> [a]
repeat' x = x : repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' [] ys         = []
zip' xs []         = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

elem' :: Eq a => a -> [a] -> Bool
elem' _ []      = False
elem' t (x:xs)
    | t == x    = True
    | otherwise = elem' t xs

-- my quicksort attempt

quicksort :: Ord a => [a] -> [a]
quicksort []     = []
quicksort (p:xs) = quicksort smaller ++ [p] ++ quicksort largerEq
    where
        smaller  = filter (<= p) xs
        largerEq = filter (> p) xs

-- book impl.

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
    let smallerOrEqual = [a | a <- xs, a <= x]
        larger = [a | a <- xs, a > x]
    in quicksort' smallerOrEqual ++ [x] ++ quicksort' larger

{-
    The general principle of recursion is to determine the base case and subproblem case correctly.

    Provided both of the latter are correct, the function will solve the problem.
    Since the solutions to subproblems will be correct.
-}