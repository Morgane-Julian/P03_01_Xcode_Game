//
//  Game.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 30/10/2020.
//

import Foundation

class Game {
    var championList : [Champion] = [Necromancer(), Monk(), DemonHunter(), Wizzard(), Crusader(), Barbarian()]
    var player1 : Player = Player(name: "Player1")
    var player2 : Player = Player(name: "Player2")
    var round : Int = 1
    var legendaryWeapons = [Gungnir(), Trisula(), Mjöllnir()]
    
    
    // Welcoming players and choosing a personalized name
    func hello(player: Player) -> String {
        print("\nHello \(player.name) ! What's your name ?")
        while let summonerName = readLine() {
            if summonerName != "" && summonerName != player1.name {
            return summonerName
            } else {
                print("⚠️ Sorry this is not a valid name, \(player.name) or this name is already taken. Please enter another name. ⚠️")
            }
        }
        return ""
    }
        

    
    // Algo that checks if the name chosen for each character isn't already taken
    func isChampionNameAvailable(userName: String) -> Bool {
        if self.player1.team.contains(where: {$0.name == userName}) || self.player2.team.contains(where: {$0.name == userName}) || userName == "" {
            return false
        }
        return true
    }
    
    // Create a champion copy with a new name
    func createChampion(category: Role) -> Champion? {
        var result : Champion?
        if let line = readLine(), let prompt = Int(line) {
            if let champion = self.championList.first(where: {$0.index == prompt}) {
                if champion.category == category {
                    print("\nWhat name would you give to your \(champion.name) ?")
                    if let promptUserName = readLine() {
                        if self.isChampionNameAvailable(userName: promptUserName) {
                            result = champion.copy()
                            result?.name = promptUserName
                        } else {
                            print("\n⚠️ This name \(promptUserName) is not available or you enter a bad name ⚠️, try again.\n")
                        }
                    }
                } else {
                    print(" \n⚠️ This champion \(champion.name) is not a \(category), it's a \(champion.category) ⚠️\n")
                }
            } else {
                print("\n⚠️ Unknow champion with index \(prompt), ⚠️ try again.\n")
            }
        } else {
            print("\n⚠️ This is not a valid choice. Try again. ⚠️")
        }
        return result
    }
    
    
    // Add the champion created previously in the table of player
    func promptChampion(_ player: Player, category: Role) {
        var champion: Champion?
        while champion == nil {
            print("\nWitch \(category) would you select in your team ? Type his index")
            champion = self.createChampion(category: category)
            if let c = champion {
                player.team.append(c)
                print("\nYou choose \(c.name) for \(category).\n")
                player.championStat.append(c)
                if let index = player.team.lastIndex(of: c) {
                    c.index = index + 1
                }
            }
        }
    }
    
    
    
    // Print the list of champions available (for champion select or game..)
    func printChampionList(champions: [Champion]) {
        for champion in champions {
            print("\(champion.index).         \(champion.name)                       \(champion.category)                 \(champion.life)/\(champion.maxLife)HP                  \(champion.weapon.weaponName)                  \(champion.weapon.weaponDamage) dmg\n")
        }
    }
    
    // Calculate if team have 3 dead champions game is over.
    func isEndGame() -> Bool {
        if self.player1.team.isEmpty || self.player2.team.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // Decide who start between 2 players.
    func whoStart() -> (Player, Player) {
        var alea = [game.player1, game.player2]
        alea.shuffle()
        print("🎲🎲🎲 Chance will decide who will strike the first blood ! 🎲🎲🎲\n")
        print("________________________________________________________________________________")
        print("\(String(describing: alea.first!.name)) begin.\n")
        return (alea.first!, alea.last!)
    }
    
    // Magic chest 3/10 chances to pop-up with five random surprise.
    func magicChest(champion: Champion) {
        let randomAppear = Int.random(in: 1...10)
        let randomContent = Int.random(in: 1...5)
        if randomAppear == 2 || randomAppear == 6 || randomAppear == 9 {
            print("🎁🎁🎁 Woooaaaa you are lucky !! A chest just popped up. 🎁🎁🎁")
            print("________________________________________________________________________________")
            
            switch randomContent {
            case 1:
                print(" ⚔️⚔️⚔️ You found a new weapon : Gungnir!! You got the power of Odin : 70 damage! ⚔️⚔️⚔️")
                if champion.category == .heal {
                    print("\nSorry, this weapon is not for heal, maybe more luck next time 🤪 ")
                } else {
                    champion.weapon = Gungnir()
                }
            case 2:
                print("⚜️⚜️⚜️ The chest was empty ⚜️⚜️⚜️")
            case 3:
                print("⚔️⚔️⚔️ You found a new weapon: Trisula! with power of 40 and heal 30! ⚔️⚔️⚔️\n")
                if champion.category == .heal {
                    champion.weapon = Trisula()
                } else {
                    print("\nSorry, this weapon is only for heal, maybe more luck next time 🤪 ")
                }
            case 4:
                print("💣💣💣💣💣💣  There was a bomb in the chest, you lose 15 points of life")
                champion.life -= 15
            case 5:
                print("⚔️⚔️⚔️ You found a new weapon: Mjöllnir with a power of 60 !! ⚔️⚔️⚔️")
                if champion.category == .heal {
                    print("\nSorry, this weapon is not for heal, maybe more luck next time 🤪 ")
                } else {
                    champion.weapon = Mjöllnir()
                }
                
            default: print("error")
            }
            print("________________________________________________________________________________")
        }
    }
    

    // Game logic with selection of two champion "playingChampion" and "Target" and logic of the selected action (heal or attack).
    func action(selectAction: String, playerAttacker: Player, playerTarget: Player) {
        var finishAction = false
        
        while finishAction == false {
            print("Wich champion will play ?")
            if let prompt = readLine(), let intPrompt = Int(prompt) {
                if let playingChampion = playerAttacker.team.first(where: {$0.index == intPrompt}) {
                    
                    
                    if selectAction == "1" {
                        magicChest(champion: playingChampion)
                        while finishAction == false {
                            print("Wich champion will suffer your attack ?")
                            let prompt = Int(readLine() ?? "")
                            if let target = playerTarget.team.first(where: {$0.index == prompt}) {
                                playingChampion.attack(target: target)
                                finishAction = true
                                if target.isAlive() {
                                    print("\(target.name) suffered \(playingChampion.weapon.weaponDamage) damage, now he have \(target.life) points of life.\n")
                                } else {
                                    print("\(target.name) suffered of \(playingChampion.weapon.weaponDamage) damage")
                                    print("☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️\n")
                                    print("        ⚠️ Warning \(target.name) is dead !! ⚠️\n")
                                    print("☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️\n")
                                    if let iD = playerTarget.team.firstIndex(of: target) {
                                        playerTarget.team.remove(at: iD)
                                    }
                                }
                            } else {
                                print("⚠️ Sorry, this is not valid ⚠️")
                            }
                        }
                    }
                    else if selectAction == "2", playingChampion.category == .heal {
                        magicChest(champion: playingChampion)
                        while finishAction == false {
                            print("Wich champion need to be healed ?")
                            let prompt = Int(readLine() ?? "")
                            if let target = playerAttacker.team.first(where: {$0.index == prompt}) {
                                playingChampion.heal(target: target)
                                finishAction = true
                                print("\(target.name) won \(playingChampion.weapon.heal)pts of life, now he have \(target.life)pts of life")
                            }
                            else {
                                print("⚠️ Sorry, you can't heal this champion. ⚠️")
                            }
                        }
                    } else {
                        print("⚠️ Sorry, this is not valid, you chose healing you have to choose a heal champion. ⚠️")
                    }
                } else {
                    print("⚠️ Sorry, this champion is not in the list, try again. ⚠️")
                }
            }
        }
    }

// Decide who start the game, print the two teams, select an action (heal or attack), swap the playerAttacker and playerTarget and increment round.
    func play() {
        let whoStart = self.whoStart()
        var playerAttacker = whoStart.0
        var playerTarget = whoStart.1
        
        while self.isEndGame() == false {
            print("\nRound n°\(round)\n")
            print("\nHere is the team of \(playerAttacker.name)\n")
            table()
            printChampionList(champions: playerAttacker.team)
            print("_____________________________________________________\n")
            print("\nHere is the team of \(playerTarget.name)")
            table()
            printChampionList(champions: playerTarget.team)
            
            var selectAction = ""
            while selectAction != "1" && selectAction != "2" {
                if playerAttacker.team.contains(where: {$0.category == .heal}) {
                    print("\(playerAttacker.name) do you want to ?\n 1. Attack an ennemy team\n 2. Heal one of your mates of 30 points of life")
                    selectAction = readLine() ?? ""
                    
                    if selectAction == "1" || selectAction == "2" {
                        self.action(selectAction: selectAction, playerAttacker: playerAttacker, playerTarget: playerTarget)
                    } else {
                        print("⚠️ Error, you have to choose 1 or 2 ⚠️")
                    }
                } else {
                    selectAction = "1"
                    self.action(selectAction: selectAction, playerAttacker: playerAttacker, playerTarget: playerTarget)
                }
            }
            
            swap(&playerAttacker , &playerTarget)
            self.round += 1
        }
    }
    
    
    
    
    
    
    
    // Print the statistics of end game.
    func printStats() {
        if let winner = [self.player1, self.player2].first(where: {!$0.team.isEmpty}), let looser = [self.player1, self.player2].first(where: {$0.team.isEmpty}) {
            victory()
            print("🥇🥇🥇 YAY!  \(winner.name) won the game. 🥇🥇🥇")
            print("Game end in \(self.round) rounds. \n")
            print("Here was the team of \(winner.name)")
            table()
            for champions in winner.championStat {
                print("\(champions.index).         \(champions.name)                       \(champions.category)                 \(champions.life)/\(champions.maxLife)HP                  \(champions.weapon.weaponName)                  \(champions.weapon.weaponDamage) dmg\n")
            }
            print("Here was the team of \(looser.name)")
            table()
            for champions in looser.championStat {
                print("\(champions.index).         \(champions.name)                       \(champions.category)                 \(champions.life)/\(champions.maxLife)HP                  \(champions.weapon.weaponName)                  \(champions.weapon.weaponDamage) dmg\n")
            }
        }
    }
    

    // New game start, call to the previously functions and output.
    func new() {
        welcome()

        self.player1.name = self.hello(player: self.player1)
        self.player2.name = self.hello(player: self.player2)

        championSelect()
        print("\n \(self.player1.name) you have too choose 3 champions 🧙🏼‍♀️🧟‍♀️🧝🏾 in your team, 1 heal, 1 tank and 1 DPS in the following list.\n")
        table()

        self.printChampionList(champions: self.championList)
        self.promptChampion(self.player1, category: .tank)
        self.promptChampion(self.player1, category: .heal)
        self.promptChampion(self.player1, category: .DPS)
        print("\nSuper! Team is ready, let's GO!\n")

        print("\n\(self.player2.name) is u turn to select a team!\n You have too choose 3 champions 🧙🏼‍♀️🧟‍♀️🧝🏾 in your team, 1 heal, 1 tank and 1 DPS in the following list.\n")
        table()

        self.printChampionList(champions: self.championList)
        self.promptChampion(self.player2, category: .tank)
        self.promptChampion(self.player2, category: .heal)
        self.promptChampion(self.player2, category: .DPS)
        print("\nSuper! Team is ready, let's GO!\n")

        gameRun()

        self.play()
        self.printStats()
    }
    
    

}

