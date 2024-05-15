#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

// Function to generate random number between min and max (inclusive)
int random(int min, int max) {
    static bool first = true;
    if (first) {
        srand(time(NULL));
        first = false;
    }
    return min + rand() % ((max + 1) - min);
}

// Main class for the game
class ClickerGame {
private:
    int clicks; // Total clicks
    int clickValue; // Value per click

public:
    // Constructor
    ClickerGame() {
        clicks = 0;
        clickValue = 1;
    }

    // Method to handle click event
    void click() {
        clicks += clickValue;
    }

    // Method to upgrade click value
    void upgradeClickValue() {
        int upgradeCost = 10 * clickValue; // Cost to upgrade click value
        if (clicks >= upgradeCost) {
            clicks -= upgradeCost;
            clickValue++;
            cout << "Click value upgraded to " << clickValue << endl;
        } else {
            cout << "Not enough clicks to upgrade click value!" << endl;
        }
    }

    // Method to display current status
    void displayStatus() {
        cout << "Total Clicks: " << clicks << endl;
        cout << "Click Value: " << clickValue << endl;
    }
};

int main() {
    ClickerGame game;

    // Main game loop
    while (true) {
        cout << "1. Click" << endl;
        cout << "2. Upgrade Click Value" << endl;
        cout << "3. Quit" << endl;
        cout << "Choose an option: ";

        int choice;
        cin >> choice;

        switch (choice) {
            case 1:
                game.click();
                break;
            case 2:
                game.upgradeClickValue();
                break;
            case 3:
                cout << "Thanks for playing!" << endl;
                return 0;
            default:
                cout << "Invalid choice! Try again." << endl;
        }

        game.displayStatus();
        cout << endl;
    }

    return 0;
}
