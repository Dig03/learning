import Data.List
import Data.Char
-- this is how we import modules
-- must be done before any definitions

numUniques :: Eq a => [a] -> Int
numUniques = length . nub
-- nub returns uniques for a list

uniques :: Eq a => [a] -> [a]
uniques = foldr (\x acc -> if x `elem` acc then acc else x : acc) []

{-
    import specific
        import Data.List (nub, sort)
    import excluding
        import Data.List hiding (nub)
    import namespaced
        import qualified Data.Map
        (reference as Data.Map)
        import qualified Data.Map as M
        (reference as M)
-}

-- solving problems with modules
{-
    Data.List

    words separates strings by whitespace
    group places repeated elements into sublists
    sort sorts lists
        combining sort and group allows all duplicates to be sublists
-}

concordance :: String -> [(String, Int)]
concordance = map (\ws -> (head ws, length ws)) . group . sort . words

isContainedIn :: Eq a => [a] -> [a] -> Bool
isContainedIn needle haystack = any (isPrefixOf needle) (tails haystack)

(<<) :: Eq a => [a] -> [a] -> Bool
(<<) subset set = any (isPrefixOf subset) (tails set)

caesar :: Int -> String -> String
caesar n = map (chr . (+n) . ord)

uncaesar :: Int -> String -> String
uncaesar n = caesar (negate n)

caesarId :: Int -> String -> String
caesarId n = (uncaesar n . caesar n)

-- Strict Left Folds
{-
    Sometimes we can cause a stack overflow due to Haskell's
    lazy evaluation.

    This causes the stack to be blown because Haskell defers
    the evaluation of a massive number of folds and embeds
    them all in the callstack.
-}

-- this isn't causing a stack overflow on my machine, but
-- excessively large values likely could
stackoverflow = foldl (+) 0 (replicate 1000000 1)

-- Data.List provides foldl', a 'strict' foldl
-- called such because it _strictly_ evaluates, no deferring
-- (same for foldl1 and foldl1')

-- digitToInt is from Data.Char
digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

firstDigitSumTo40 :: Int
firstDigitSumTo40 = 1 + (length . takeWhile (< 40) $ map digitSum [1..])

-- a better alternative is 'find' from Data.List
-- find returns the first element meeting some predicate
-- however it returns it as a Maybe
-- Maybe is used to represent possible failure
-- Something of type Maybe is either Just a
-- or Nothing

firstDigitSumTo40' :: Maybe Int
firstDigitSumTo40' = find ((== 40) . digitSum) [1..]

firstDigitSumTo :: Int -> Maybe Int
firstDigitSumTo n = find ((== n) . digitSum) [1..]

fancyFirstDigitSumTo :: Int -> Integer
fancyFirstDigitSumTo n = read (intToDigit (n `mod` 9) : replicate (n `div` 9) '9') :: Integer

abbrevFancyFirstDigitSumTo :: Int -> (Int, Int)
abbrevFancyFirstDigitSumTo n = (n `mod` 9, n `div` 9)

-- mapping keys to values

{- BOOKMARK: PAGE 98 -}