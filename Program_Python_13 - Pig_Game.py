import random

class Die:
    value:int = 0
                
    def roll(self):
        self.value = random.randrange(1, 7)

class Dice:
    # use traditional initializer bc @dataclass doesn't allow
    # attributes with mutable default (such as list)
    def __init__(self):
        self.all = []

    def addDie(self, die):
        self.all.append(die)
                
    def rollAll(self):
        for die in self.all:
            die.roll()

class Game:
    __turn:int = 1
    __score:int = 0
    __scoreThisTurn:int = 0
    __isTurnOver:bool = False
    __isGameOver:bool = False
    __die:Die = Die()

    def play(self):
        while not self.__isGameOver:
            self.takeTurn()

    def takeTurn(self):
        print("TURN", self.__turn)
        self.__scoreThisTurn = 0
        self.__isTurnOver = False
        while not self.__isTurnOver:
            choice = input("Roll or hold? (r/h): ")
            if choice == "r":
                self.rollDie()
            elif choice == "h":
                self.holdTurn()
            else:
                print("Invalid choice. Try again.")

    def rollDie(self):
        self.__die.roll()
        print("Die:", self.__die.value)
        if self.__die.value == 1:
            self.__scoreThisTurn = 0
            self.__turn += 1
            self.__isTurnOver = True
            print("Turn over. No score.\n")
        else:
            self.__scoreThisTurn += self.__die.value

    def holdTurn(self):
        self.__score += self.__scoreThisTurn
        self.__isTurnOver = True
        print("Score for turn:", self.__scoreThisTurn)
        print("Total score:", self.__score, "\n")
        if self.__score >= 20:
            self.__isGameOver = True
            print("You finished in", self.__turn, "turns!")
        else:
            self.__turn += 1
def display_welcome():
    print("Let's Play PIG!")
    print()
    print("* See how many turns it takes you to get to 20.")
    print("* Turn ends when you hold or roll a 1.")
    print("* If you roll a 1, you lose all points for the turn.")
    print("* If you hold, you save all points for the turn.")
    print()

def main():
    display_welcome()

    choice = "y"
    while choice.lower() == "y":
        game = Game()
        game.play()
        
        choice = input("Play again? (y/n): ")
        print()
       
    print("Bye!")
        
# if started as the main module, call the main function
if __name__ == "__main__":
    main()