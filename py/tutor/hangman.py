"""
Hangman Game

#1. Choose an answer
#2. Ask the user for a single letter.
#3. Check if that letter is in the answer.
#If the letter IS in the answer:
#    4. Reveal that letter in the answer.
#If the letter ISN'T in answer:
#    5. Tell the user the letter isn't in the answer.
6. Check if the user has won. (if they have won: say yay, ask them to play again)
7. Go back to 2.
"""
import random

print("Welcome to Hangman")

answers = ["dog", "cat", "hello", "python"]
answer = random.choice(answers)

correct_guesses = []

while True:
    guess = input("Make a guess: ")
    if len(guess) != 1:
        print("One letter please")
    else:
        if guess in answer:
            # for _ in range(answer.count(guess)):
            correct_guesses.append(guess)
            for letter in answer:
                if letter in correct_guesses:
                    print(letter, end='')
                else:
                    print("-", end='')
            print()
        else:
            print("Not in the answer.")

        if set(correct_guesses) == set(answer):
            print("Yay you won!")
            break
