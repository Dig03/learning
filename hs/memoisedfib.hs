memoised_fib :: Int -> Integer
memoised_fib = (map fib [0 ..] !!)
              where fib 0 = 0
                    fib 1 = 1
                    fib n = memoised_fib (n - 2) + memoised_fib (n - 1)

{-
    memoised_fib 4

    (map fib [0 ..] !!) 4

    4th index is (fib 4)
    (fib 4) is memoised_fib 2 + memoised_fib 3

        memoised_fib 3

        (map fib [0 ..] !!) 3

        3rd index is (fib 3)
        (fib 3) is memoised_fib 1 + memoised_fib 2

            memoised_fib 2

            (map fib [0 ..] !!) 2

            2nd index is (fib 2)
            (fib 2) is memoised_fib 0 + memoised_fib 1

                memoised_fib 1

                (map fib [0 ..] !!) 1

                1st index is (fib 1)
                (fib 1) = 1

                [fib 0, 1, fib 2, fib 3, fib 4]
                
                --

                memoised_fib 0

                (map fib [0 ..] !!) 0

                0th index is (fib 0)
                (fib 0) = 0

                [0, 1, fib 2, fib 3, fib 4]

            (fib 2) is 0 + 1

            [0, 1, 1, fib 3, fib 4]
            ... list filled from bottom
-}