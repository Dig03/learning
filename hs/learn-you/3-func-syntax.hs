-- pattern matching is used to specify patterns which data should match in order to process it
-- in the following, '7' is pattern matched, and 'x' matches anything else

lucky 7 = "YES!"
lucky x = "Sorry, out of luck."

-- functions should have these catch all patterns, to prevent exceptions

-- tuple matching

vecMidpoint :: (Double, Double) -> (Double, Double) -> (Double, Double)
vecMidpoint (x0, y0) (x1, y1) = ((x0 + x1)/2, (y0 + y1)/2)

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- examples of array matching

tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

-- "as-patterns" can be used to simultaneously match an entire list while also using a pattern

firstLetter :: String -> String
firstLetter "" = "Empty, no start!"
firstLetter l@(x:xs) = [x] ++ " is the first letter of " ++ l

{- BOOKMARK: page 40 -}