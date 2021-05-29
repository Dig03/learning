import random


def make_game_board(size=3):
    board = []
    for _ in range(size):
        row = []
        for _ in range(size):
            row.append(" ")
        board.append(row)
    return board


SIDE_LENGTH = 5

game_board = make_game_board(SIDE_LENGTH)


def print_game_board(game_board):
    result = ""
    for row in game_board:
        for character in row[:-1]:
            result += character + '|'
        result += row[-1] + '\n'
    print(result)


def get_move_pos(num, board):
    row = num // len(board[0])
    col = num % len(board[0])
    return (row, col)


def make_move(player, board):
    while True:
        move = input("What's your move? ")
        num = ord(move) - 97
        row, col = get_move_pos(num, board)
        if board[row][col] == " ":
            board[row][col] = player
            break
        else:
            print("Someone's already moved there!")


def make_random_move(player, board):
    while True:
        o = random.randint(0, SIDE_LENGTH * SIDE_LENGTH - 1)
        row, col = get_move_pos(o, board)
        if board[row][col] == " ":
            board[row][col] = player
            break
    """
    1. choose a random number
    2. turn the number into a board position
    3. check if you can move there
    4. move if can, random again if you can't
    """


def check_win(game_board):
    """
    two players - "x", "o"

    1. for every player: "x" or "o"
        2. every row (see if a win is there)
        3. every column
        4. every diag
    """
    PLAYERS = ["x", "o"]

    for player in PLAYERS:
        # check rows
        for row in game_board:
            if row.count(player) == len(row):
                return player

        # check columns
        for i in range(len(game_board)):
            column = [row[i] for row in game_board]
            if column.count(player) == len(column):
                return player

        # check diagonals
        diagonal = []
        for i in range(len(game_board)):
            diagonal.append(game_board[i][i])

        if diagonal.count(player) == len(diagonal):
            return player

        diagonal = []
        """
        top right - (0, 2)
        (1, 1)
        (2, 0)

        (0, LENGTH - 1 - 0)
        (1, LENGTH - 1)
        (2, LENGTH - 2)
        ...
        (n, LENGTH - n)

        """
        for i in range(len(game_board)):
            diagonal.append(game_board[i][len(game_board) - 1 - i])

        if diagonal.count(player) == len(diagonal):
            return player

    return ""


if __name__ == "__main__":
    keep_playing = True
    while keep_playing:
        print_game_board(game_board)
        #print('*|*|* \n*|*|* \n*|*|*')
        make_move("x", game_board)

        winner = check_win(game_board)
        if winner:
            print(winner + " won!")
            break

        make_random_move("o", game_board)
