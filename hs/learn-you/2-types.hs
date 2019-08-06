{-
    - ':t' is a GHCi command to determine the type of something
    - '::' is read "has type of"
    -- Int is bounded, Integer isn't, case in point:
-}

factorial :: Integer -> Integer
factorial n = product [1..n]

-- other types, Float, Double, Bool, Char etc. all fairly standard
-- type variables allow for flexible functions which are _polymorphic_, e.g. head :: [a] -> a (for any type a)

{-
    Typeclasses are interfaces that describe some kind of behaviour in Haskell.
    (==) :: Eq a => a -> a -> Bool

    Here we see a class constraint, denoted by "=>", in this case, an instance of Eq must exist for a.
    (or a must be an instance of Eq? terminology is weird)

    Examples:
        - Eq: equality testing
        - Ord: natural ordering
            - the "compare" function can return GT, LT or EQ ("Ordering" objects) (greater-than .. etc)
        - Show: things which can be displayed as strings (how should they be represented?)
            - the "show" function gets this string
        - Read: opposite of show, converts strings back to objects
            - the "read" function does this
        - Enum: things which can be enumerated, like list ranges
        - Bounded: things which are bounded
            - the "minBound" and "maxBound" functions allow us to check these bounds for each type
                - despite being "functions", they can be described as "polymorphic constants"
        - Num: things which act like numbers
        - Floating: floating point numbers are needed, e.g. for sin, cos etc.
        - Integral: whole numbers
            - "fromIntegral" to convert Integrals to something more useful
    Some typeclasses are prerequisites for others, e.g. a member of Ord must also be in Eq.
    (since if you can check if it is equal you must be able to order it)
-}