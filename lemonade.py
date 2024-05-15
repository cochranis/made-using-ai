import time

class LemonadeStand:
    def __init__(self):
        self.lemons = 0
        self.sugar = 0
        self.ice = 0
        self.cups = 0
        self.money = 0
        self.price = 1
        self.customers = 0

    def display_stats(self):
        print("\n--- Lemonade Stand Stats ---")
        print(f"Lemons: {self.lemons}")
        print(f"Sugar: {self.sugar}")
        print(f"Ice: {self.ice}")
        print(f"Cups: {self.cups}")
        print(f"Money: ${self.money}")
        print(f"Price per Cup: ${self.price}")
        print(f"Customers served: {self.customers}")

    def serve_customers(self):
        if self.lemons >= 1 and self.sugar >= 1 and self.ice >= 1 and self.cups >= 1:
            self.lemons -= 1
            self.sugar -= 1
            self.ice -= 1
            self.cups -= 1
            self.money += self.price
            self.customers += 1
            print("\nYou served a cup of lemonade to a customer!")
        else:
            print("\nYou don't have enough ingredients to serve a cup of lemonade.")

    def buy_ingredient(self, ingredient, cost):
        if self.money >= cost:
            self.money -= cost
            if ingredient == "lemons":
                self.lemons += 1
            elif ingredient == "sugar":
                self.sugar += 1
            elif ingredient == "ice":
                self.ice += 1
            elif ingredient == "cups":
                self.cups += 1
            print(f"\nYou bought 1 {ingredient}.")
        else:
            print("\nYou don't have enough money to buy this.")

    def upgrade_price(self):
        self.price += 0.5
        print(f"\nPrice per cup increased to ${self.price}.")

def main():
    stand = LemonadeStand()
    while True:
        stand.display_stats()
        print("\nWhat would you like to do?")
        print("1. Serve customers")
        print("2. Buy ingredients")
        print("3. Upgrade price per cup")
        print("4. Exit")

        choice = input("> ")

        if choice == "1":
            stand.serve_customers()
            time.sleep(1)
        elif choice == "2":
            print("\nWhat would you like to buy?")
            print("1. Lemons ($1)")
            print("2. Sugar ($1)")
            print("3. Ice ($1)")
            print("4. Cups ($1)")
            ingredient_choice = input("> ")
            if ingredient_choice == "1":
                stand.buy_ingredient("lemons", 1)
            elif ingredient_choice == "2":
                stand.buy_ingredient("sugar", 1)
            elif ingredient_choice == "3":
                stand.buy_ingredient("ice", 1)
            elif ingredient_choice == "4":
                stand.buy_ingredient("cups", 1)
            else:
                print("\nInvalid choice.")
            time.sleep(1)
        elif choice == "3":
            stand.upgrade_price()
            time.sleep(1)
        elif choice == "4":
            print("\nThanks for playing!")
            break
        else:
            print("\nInvalid choice.")

if __name__ == "__main__":
    main()
