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

-- "guards" are a concept in haskell which allows for quite elegant conditional checking

data BMI = Underweight | Normal | Overweight | Obese 
    deriving (Show, Eq)

-- deriving lets us automatically define typeclass instances

-- this is basically an if, elif, ..., elif, else chain

bmiConv :: Double -> BMI
bmiConv b
    | b <= 18.5 = Underweight -- if
    | b <= 25.0 = Normal      -- elif
    | b <= 30.0 = Overweight
    | otherwise = Obese       -- else

bmi :: Double -> Double -> Double
bmi h w = w/h^2

-- you can store intermediate results with "where", the scope is specific to a pattern,
-- so multiple patterns (e.g. fib 1, fib 0 etc.) have their own "where"
-- bindings can also be pattern matched, e.g. multiple assignment (a, b, c) = (1, 2, 3)

bmiInfo :: Double -> Double -> String
bmiInfo h w
    | bmiv == Underweight = "Oh you should eat!"
    | bmiv == Normal      = "Looking good!"
    | bmiv == Overweight  = "Little bit too heavy!"
    | bmiv == Obese       = "Better work out!"
        where bmiv = bmiConv (bmi h w)

bmiConvList :: [(Double, Double)] -> [BMI]
bmiConvList = map (bmiConv . (uncurry bmi))

-- "let" expressions are like "where" but they are actually expressions, that evaluate to something
-- let <bindings> in <expression> -> resolves to expression where bindings are set
-- let can introduce functions in local scopes, and do all sorts of useful stuff
-- semicolons can separate the bindings (e.g. let a = ...; b = ... in a + b)
-- let is very useful for quickly pattern matching also (e.g. to quickly decompose a tuple)

six = let (a, b, c) = (1, 2, 3) in a + b + c

-- "let" can also be used in list expressions

calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]

-- if there is no "in" to the let in GHCi, then the value is saved for the session

-- "case" allows for pattern matching anywhere in code

head' :: [a] -> a
head' xs = case xs of [] -> error "No head for empty lists!"
                      (x:_) -> x

-- the syntax is effectively:
{-
    case (expression to match) of pattern -> result
                                  pattern -> result
                                  ... etc
-}

-- case can be used basically anywhere
describeList :: [a] -> String
describeList ls = "The list is " ++ case ls of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."
