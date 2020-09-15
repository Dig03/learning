data Fib a = Fib Integer

fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

instance Monad Fib where
    (Fib i) >>= f = f (fib i)

