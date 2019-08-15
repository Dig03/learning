import Data.List
import Data.Char
import qualified Data.Map as Map
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

{-
    We can achieve a key-value mapping in many ways.
    One such way is an Association List, a list used to store
    key/value pairs where ordering doesn't matter.

    One such way to represent these in Haskell, is a list
    of tuples. s.t. [(Key, Value)]
    The following functions are the implementation of such a
    system.
-}

lookup' :: Eq k => k -> [(k, v)] -> Maybe v
lookup' _ []     = Nothing
lookup' k ((x, v):xs)
    | k == x    = Just v
    | otherwise = lookup' k xs

findKey :: Eq k => k -> [(k, v)] -> v
findKey key xs = snd . head . filter (\(k, v) -> key == k) $ xs
-- bad because possible runtime error

findKey' :: Eq k => k -> [(k, v)] -> Maybe v
findKey' key = foldr (\(k, v) acc -> if key == k then (Just v) else acc) Nothing

-- Data.Map

{-
    The above was an implementation of lookup from Data.List

    Map offers a sort of association list which is much faster
    than our implementation.

    Map.fromList allows us to convert a [(k, v)]-style association
    list to a Map.
-}

phoneBook :: Map.Map String String
phoneBook = Map.fromList $
    [("betty", "555-2938")
    ,("bonnie", "452-2928")
    ,("patsy", "493-2928")
    ,("lucille", "205-2928")
    ,("wendy", "939-8282")
    ,("penny", "853-2492")
    ]

-- Map.lookup allows us to lookup keys in the same way as before

wendyNumber :: Maybe String 
wendyNumber = Map.lookup "wendy" phoneBook

-- Map.insert allows us to insert new entries into the map

updatedPhoneBook :: Map.Map String String
updatedPhoneBook = Map.insert "grace" "341-9021" phoneBook

-- Map.size returns the number of entries in a Map