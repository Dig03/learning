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

{- BOOKMARK: PAGE 93 -}