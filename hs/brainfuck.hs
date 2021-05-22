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
import Data.Stream
import Data.Word
import Data.Char

main = brainfuck

data Instruction = Left
                 | Right
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

type Byte = Word8

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

-- read a single char into the current cell
get :: Tape Byte -> Tape Byte
get (Tape left right current) = Tape left right (getChar)

parseChar :: Char -> Instruction
parseChar '<' = Left
parseChar '>' = Right
parseChar '+' = Inc
parseChar '-' = Dec
parseChar '.' = Print
parseChar ',' = Read
parseChar '[' = OpenLoop
parseChar ']' = CloseLoop

parse :: String -> [Instruction]
parse = map parseChar

brainfuck :: IO ()
brainfuck = print "unimplemented"

