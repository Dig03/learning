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

{- BOOKMARK: PAGE 67 -}