-- a function is "higher order" if it uses functions as parameters or return values

-- all functions in haskell (normally) only take one parameter because they are "curried"
-- in short, (max 4) returns a function that will always compare the given number to 4, and return it
-- iff it is bigger, otherwise it will return 4. this principle can be generalised to all functions in haskell
-- provided they are curried.

-- a -> a -> a    <->    a -> (a -> a)

mul3 :: Int -> Int -> Int -> Int
mul3 x y z = x * y * z

mul2w9 = mul3 9

-- this sort of situation also leads to us being able to remove extraneous parameters in function definitions,
add1toall :: Num a => [a] -> [a]
add1toall x = map (\i -> i + 1) x
-- equ. add1toall = map (\i -> i + 1)
-- since by map's type we know it is going to receive a list.

-- infix functions are partially applied using "sections" e.g.
divideByTen :: Floating a => a -> a
divideByTen = (/10)
-- the surrounding by parentheses here creates the "section"
isUpper :: Char -> Bool
isUpper = (`elem` ['A'..'Z'])
-- an exception to the rules of sectioning is the minus '-' operator: (-4) just means negative four

-- be careful when defining the types of functions that receive functions as parameters
-- since LHS brackets stick, while RHS ones don't, e.g.
-- a -> (a -> a) =/ (a -> a) -> a
-- LHS is just a -> a -> a, RHS is one function as parameter, returns a
-- -> is right-associative

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _          = []
zipWith' _ _ []          = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f a b = f b a

map' :: (a -> b) -> [a] -> [b]
map' _ []     = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x       = x : filter' f xs
    | otherwise = filter' f xs

-- largest number under 100,000 divisble by 3,829

largestDivisible :: Integer
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0

-- takeWhile 'takes' while a predicate is true, e.g.
-- takeWhile (/= ' ') "elephants know how to party" == "elephants"

collatz :: Integer -> [Integer]
collatz 1 = [1]
collatz x
    | even x = x:collatz (x `div` 2)
    | odd  x = x:collatz (3 * x + 1)

-- for starting numbers between 1..100, how many have a length greater than 15?
answer :: Int
answer = length (filter (> 15) (map (length . collatz) [1..100]))

-- mapping functions with multiple parameters is possible
-- it will generate a list of partially applied functions
-- if you map a function with a lower amount of params
-- than expected

-- lambdas can allow for anonymous functions to be quickly
-- deployed (one time use)
-- however remember to use currying and partial app. where possible

ex :: Integer -> Integer
ex = \x -> x + 1
-- you can pattern match on parameters as well, but only one case
-- otherwise there is a runtime error

-- lambdas also let you demonstrate currying with a neat gimmick

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

addThree' :: Int -> Int -> Int -> Int
addThree' = \x -> \y -> \z -> x + y + z
-- lambdas can also be optionally enclosed with parens,
-- without they encapsulate everything to the right of ->
-- writing lambdas can be used to explicitly show that
-- functions are meant to be partially applied, e.g.

flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f = \x y -> f y x

{-
    earlier when designing recursive functions they all
    followed a similar pattern, a base case, and a
    recursive case; for lists, [] and (x:xs)

    this pattern is encapsulated into 'folds' in haskell.
    when you want to traverse a data structure and reduce
    it into a single value, you can use a fold (usually
    it's a list)

    a fold takes a 'binary function', (aka accumulator) and
    a list to fold up, lists can be folded from the left or
    right

    the accumulator is progressively applied to the list,
    with the accumulator function being applied again to
    the accumulated value along with the next first, or last
    element of the structure
-}

-- left folds with foldl
sum' :: Num a => [a] -> a
sum' = foldl (+) 0
-- left folds fold up from the left side, the binary function
-- is applied btween the starting accumulator and the head
-- of the list
{-
    0 + 3
        [3,5,2,1]
    3 + 5
        [5,2,1]
    8 + 2
        [2,1]
    10 + 1
        [1]
    11

    The previous accumulator value is applied with the next
    element of the list in each step.
-}

-- right folds with foldr
map'' :: (a -> b) -> [a] -> [b]
map'' f = foldr (\x acc -> f x : acc) []
-- foldr accumulates values from the right (last element) rather
-- than the left (first element)
-- as a result, the accumulator and current values are reversed
-- (it is \acc x -> ... in foldl)
-- this parameter ordering reflects the natural ordering
-- inherent in the strategy of each type of fold

-- left folds usually need to use ++ due to the types
-- involved, therefore right folds are usually quicker
-- when dealing with the parsing of lists

-- additionally, right folds work on infinite lists, but left
-- ones don't

elem' :: Eq a => a -> [a] -> Bool
elem' y ys = foldr (\x acc -> if x == y then True else acc) False ys

-- foldl1 and foldr1 assume the first (or last) element
-- of the list to be the starting accumulator, e.g.

maximum' :: Ord a => [a] -> a
maximum' = foldl1 max

-- warning: '1' versions fail on empty lists, since they
-- require at least one element to be used as a start

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []

product' :: Num a => [a] -> a
product' = foldl (*) 1

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' p = foldl (\acc x -> if p x then acc ++ [x] else acc) []

filter''' :: (a -> Bool) -> [a] -> [a]
filter''' p = foldr (\x acc -> if p x then x : acc else acc) []

last' :: [a] -> a
last' = foldl1 (\acc x -> x)

{-
    A right fold, with binary function f, and initial accumulator z,
    over [3,4,5,6] looks like:

    f 3 (f 4 (f 5 (f 6 z)))

    if f = +, z = 0 then

    3 + (4 + (5 + (6 + 0)))

    A left fold, with g, and initial z looks like:

    g (g (g (g z 3) 4) 5 6)

    if g = flip (:), z = [] then

    flip (:) (flip (:) (flip (:) (flip (:) [] 3) 4) 5) 6 
-}

-- folding infinite lists
{-
    If we view folds in the way we have, it can answer why
    foldr can work on infinite lists.

    let's implement and in a fold
-}

and' :: [Bool] -> Bool
and' = foldr (&&) True

{-
    We know how this would evaluate.
    Now, a common boolean optimisation is short-circuiting,
    if in a chain of &&, a false exists, there is no point
    in evaluating further, since it will always be false.

    Therefore if this foldr is ran on an infinite list that
    contains a false (relatively) early on, then it will terminate
    due to Haskell's lazy evaluation throwing out the &&'s

    (since && disregards its second parameter when the first is false)
-}

-- scans allow us to debug folds

{-
    scanl, scanr, scanl1, and scanr1 are functions that act
    exactly like folds, however they instead return a list
    consisting of all of the intermediate accumulator states
    during the fold.

    Scans can also be leveraged to allow us to observe how
    a fold progresses, when the fold is a sum, we can see
    how this could be useful.
-}

sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1
-- how many sqrtSums before we go above 1000?

-- function application with $
{-
    ($) :: (a -> b) -> a -> b
    f $ x = f x

    This applies variables to a function.
    This can be used to make a more interesting partial application
    map.

    $ has the lowest precedence, and is also right-associative,
    these properties are directly opposite to normal function app.
    
    $ can also make things clearer in situations where there are many
    brackets.
-}

-- function composition with (.)
{-
    (.) :: (b -> c) -> (a -> b) -> a -> c
    f . g = \x -> f (g x)

    This is basically successive function application.
    f must take the result type of g, leading to the type
    signature.
    Remember to bind type signatures to their intuitions.

    \x -> negate (abs x)   <->   (negate . abs)
-}

-- multiple parameter function composition
{-
    If we want to use functions taking several parameters,
    we must partially apply them so that each involved function
    only takes one parameter.

    sum (replicate 5 (max 6.7 8.9))
        <->
    (sum . replicate 5) max 6.7 8.9
        <->
    sum . replicate 5 $ max 6.7 8.9

    A rule for conversion is:
        write out the innermost function + params,
        put $ before it,
        compose all functions before it by writing them without
        their last parameter, 
        and putting dots between them

    replicate 2 (product (map (*3) (zipWith max [1,2] [4,5])))
        <->
    replicate 2 . product . map (*3) $ zipWith max [1,2] [4,5]
-}

-- point-free style
{-
    writing
        sum' xs = foldl (+) 0 xs
    as
        sum' = foldl (+) 0

    this is called "point-free" because the functions lack
    'points', or arguments (like mathematical functions)

    fn x = ceiling (negate (tan (cos (max 50 x))))
        <->
    fn = ceiling . negate . tan . cos . max 50

    writing things in point-free style is usually more readable,
    however for particularly long chains it may not be, therefore
    let bindings should be used to make intermediate results look
    nicer (or where)
-}

oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2 [1..]))))

oddSquareSum' :: Integer
oddSquareSum' = sum . takeWhile (<10000) . filter odd $ map (^2) [1..]