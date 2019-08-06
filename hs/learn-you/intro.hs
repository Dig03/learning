-- Simple doubling functions.
doubleMe :: Integer -> Integer
doubleMe x = x + x
doubleUs :: Integer -> Integer -> Integer
doubleUs x  y = doubleMe x + doubleMe y

-- Simple conditional.
doubleSmallNumber x = if x > 100
                      then x
                      else x * 2

-- Constant "function".
myString :: String
myString = "Hey there!"

-- Some list stuff.
-- Concatenation.
{-
    Warning: concatenation traverses the LHS list,
    so if it's big there might be a performance hit.
-}
appendOne :: [Integer] -> [Integer]
appendOne xs = xs ++ [1]

-- Cons (a -> [a] -> [a]) 1:[2] -> [1,2]
prependOne :: [Integer] -> [Integer]
-- This operation is very efficient and almost instant.
prependOne = (1 :)
{-
    List literals are actually syntactic sugar for
    cons-with-empty expressions, e.g.
    [1,2,3] <-> 1:2:3:[]
-}
getFirst :: [a] -> a
getFirst = flip (!!) 0
{-
    could be written "getFirst xs = xs !! 0"
    this serves as another partial application example
    additionally, this function is dangerous to use as it can
    error
-}

-- Lists can obviously be nested etc.

{-
    Some useful list structure operations:
    head - first element
    tail - everything except first
    last - last elememnt
    init - everything except last element
    length - obvious
    null - checks if list is empty
    reverse - obvious
    drop :: Int -> [a] -> [a]
        - drops n elements from the list
    maximum, minimum - obvious
    sum, product - obvious
    elem :: Eq a => a -> [a] -> Bool
        - checks membership
-}

{-
    Lists can be described using ranges:
    [1..20] -> all numbers 1 to 20
    Works for characters too, defined as ASCII order:
    ['a'..'z']
    ['A'..'Z'] ..etc

    A step can be specified like so:
    [2,4..20] -> even numbers in 1 to 20

    Also [20..1] is the empty list, you must specify
    a reverse step e.g. [20,19..1] to get the expected
    result.

    Ranges can also be infinite, and are safe so long
    as you don't try to totally evaluate them,

    e.g. take 24 [13,26..] are the first 24 multiples of 
    13.
-}

{-
    Functions for generating infinite lists include:
    cycle :: [a] -> [a]
        - repeats input list infinitely
    repeat :: a -> [a]
        - takes a single element and repeats it 
          infinitely
    (not infinite but useful):
    replicate :: Int -> a -> [a]
        - e.g. replicate 3 10 = [10, 10, 10]
-}

{-
    List comprehensions allow for a more advanced
    version of this.

    e.g. [x*2 | x <- [1..10]]
    can be read "all x * 2 (even numbers) for x in 1 to 10"

    additional arbitrary constraints can also be
    introduced
    e.g. [x | x <- [50..100], x `mod` 7 == 3]
    (backticks indicate an infix operation
    f a b <-> a `f` b)

    Everything to the left of | is an expression, so
    if .. else .. can be used there, for example
    to generate results (e.g. strings) for a list on
    some condition.

    You can pull multiple variables:
    [x | x <- [1,2,3], y <- [10, 100, 1000]]
    (lists furthest right spin fastest, like counting)
    -> [11, 101, 1001, 12, 102 ...]

    List comprehensions can also be nested.
-}

length' :: [a] -> Integer
length' xs = sum [1 | _ <- xs]

-- fizzbuzz for good measure

fizzbuzzConv :: Integer -> String
fizzbuzzConv n
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod` 3 == 0  = "Fizz"
    | n `mod` 5 == 0  = "Buzz"
    | otherwise = show n

fizzbuzz :: Integer -> Integer -> [String]
fizzbuzz a b = map fizzbuzzConv [a..b]

fizzbuzzDisp :: IO ()
fizzbuzzDisp = putStrLn (unlines (fizzbuzz 1 100))

{-
    Tuples are like lists but can contain multiple types,
    however they have a fixed length.

    This allows us to write code where we expect iterable
    structures of a fixed length, e.g. 2D vectors

    for example, a list of 2D points could be either:
    [[Integer]]

    or

    [(Integer, Integer)]

    In the former case, it is possible to have more than 2
    coordinates as each indice of the list.

    fst and snd are functions that do obvious things to
    a 2 length tuple.
    (otherwise we have to use pattern matching)
-}

doubleSucc :: (Enum a, Enum b) => (a, b) -> (a, b)
doubleSucc (x, y) = (succ x, succ y)

nSucc :: Enum a => [a] -> [a]
nSucc = map succ

swap :: (Enum a, Enum b) => (a, b) -> (b, a)
swap t = (snd t, fst t)

-- right triangles satisfying specific conditions
triples = [(a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a + b + c == 24]

-- Quick memory notes on foldr
lmax :: [Double] -> Double
lmax = foldr max (-1/0)
lmin :: [Double] -> Double
lmin = foldr min (1/0)
{-
    Default values are Infinity and -Infinity since
    those are the first assumption values when computing
    maximums (e.g. what is the least possible maximum? or
    what is the highest possible minimum?), this ensures
    any values in the list immediately override the 
    function.
-}