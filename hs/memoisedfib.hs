memoised_fib :: Int -> Integer
memoised_fib = (map fib [0 ..] !!)
              where fib 0 = 0
                    fib 1 = 1
                    fib n = memoised_fib (n - 2) + memoised_fib (n - 1)
