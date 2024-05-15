package main

import (
    "fmt"
    "time"
)

// Player represents the player in the game.
type Player struct {
    ClickPower int
    Gold       int
}

// Upgrade represents an upgrade available for purchase.
type Upgrade struct {
    Name        string
    ClickPower  int
    Cost        int
    Description string
}

func main() {
    player := Player{
        ClickPower: 1,
        Gold:       0,
    }

    upgrades := []Upgrade{
        {"Click Power +1", 1, 10, "Increase your click power by 1"},
        {"Click Power +5", 5, 50, "Increase your click power by 5"},
        {"Click Power +10", 10, 100, "Increase your click power by 10"},
    }

    fmt.Println("Welcome to the Incremental Clicker Game!")
    fmt.Println("Earn gold by clicking. Use gold to purchase upgrades.")

    go autoCollectGold(&player)

    for {
        fmt.Println("Gold:", player.Gold)
        fmt.Println("Click Power:", player.ClickPower)
        fmt.Println("Upgrades Available:")
        for i, upgrade := range upgrades {
            fmt.Printf("%d. %s - Cost: %d - %s\n", i+1, upgrade.Name, upgrade.Cost, upgrade.Description)
        }

        fmt.Println("Enter the number of the upgrade you want to purchase (or 0 to exit):")
        var choice int
        fmt.Scanln(&choice)

        if choice == 0 {
            fmt.Println("Thanks for playing!")
            break
        }

        if choice > 0 && choice <= len(upgrades) {
            upgrade := upgrades[choice-1]
            if player.Gold >= upgrade.Cost {
                player.Gold -= upgrade.Cost
                player.ClickPower += upgrade.ClickPower
                fmt.Println("Upgrade purchased:", upgrade.Name)
            } else {
                fmt.Println("Not enough gold to purchase upgrade.")
            }
        } else {
            fmt.Println("Invalid choice. Please enter a valid upgrade number.")
        }
    }
}

func autoCollectGold(player *Player) {
    for {
        player.Gold += player.ClickPower
        time.Sleep(1 * time.Second)
    }
}
