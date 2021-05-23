{-
  BRAINFUCK:
    >
      move one cell right
    <
      move on cell left
    +
      increment byte at counter
    -
      decrement byte at counter
    .
      print byte at counter
    ,
      accept one byte of input, storing at position
    [
      if the byte at the data pointer is zero, jump to ]
    ]
      if the byte at the data pointer is non-zero, jump back to [
-}

import qualified Data.Stream as S
import Data.Stream (Stream, (<:>))
import Data.Word
import Data.Char
import System.IO
import System.Environment
import System.Exit

data Instruction = TapeLeft
                 | TapeRight
                 | Inc
                 | Dec
                 | Print
                 | Read
                 | OpenLoop
                 | CloseLoop

-- a good safe representation of tape is the "infinity to the left",
-- the "infinity to the right", and the current cell
-- we can progress appropriately by moving these streams around
--
-- the 'head' of each stream represents the closest position to current
-- this allows us to "zip" along where we just pop and remove heads of lists
-- otherwise the lists are just infinite zeroes
data Tape a = Tape (Stream a) (Stream a) a

-- IO stored in the state as we basically build an IO thunk which eventually gets resolved
data State a = State (Tape a) (IO ())

type Byte = Word8
type BrainfuckSource = [Instruction]

-- move the infinite tape left
left :: Tape a -> Tape a
left (Tape left right current) = Tape new_left new_right new_current
    where
        new_left = S.tail left
        new_right = current <:> right
        new_current = S.head left

-- move the infinite tape right
right :: Tape a -> Tape a
right (Tape left right current) = Tape new_left new_right new_current
    where
        new_left = current <:> left
        new_right = S.tail right
        new_current = S.head right

-- increment the cell at the current position
inc :: Tape Byte -> Tape Byte
inc (Tape left right current) = Tape left right (current + 1)

-- decrement the cell at the current position
dec :: Tape Byte -> Tape Byte
dec (Tape left right current) = Tape left right (current - 1)

-- print the current cell as a char
put :: Tape Byte -> IO ()
put (Tape left right current) = putChar (chr (fromEnum current))

charToWord8 :: Char -> Word8
charToWord8 = toEnum . fromEnum

-- read a single char into the current cell
-- get :: Tape Byte -> Tape Byte
-- get (Tape left right current) = do
--     char <- getChar
--     Tape left right (charToWord8 char)

parseChar :: Char -> Instruction
parseChar '<' = TapeLeft
parseChar '>' = TapeRight
parseChar '+' = Inc
parseChar '-' = Dec
parseChar '.' = Print
parseChar ',' = Read
parseChar '[' = OpenLoop
parseChar ']' = CloseLoop

parse :: String -> BrainfuckSource
parse = map parseChar

brainfuck :: Tape Byte -> BrainfuckSource -> IO ()
brainfuck _ _ = print "unimplemented"

zeroes :: Stream Byte
zeroes = S.repeat 0

initialTape :: Tape Byte
initialTape = Tape zeroes zeroes 0

interpFile :: String -> IO ()
interpFile path = do
    contents <- readFile path
    brainfuck initialTape (parse contents)

exit = exitWith ExitSuccess
exitFail  = exitWith (ExitFailure 1)

parseArgs ["-h"] = usage >> exit
parseArgs []     = putStrLn "no input file" >> exit
parseArgs [path] = readFile path
parseArgs _      = putStrLn "invalid input" >> exitFail

usage = putStrLn "Usage: brainfuck [-h] [file]"

main = getArgs >>= parseArgs >>= interpFile 
