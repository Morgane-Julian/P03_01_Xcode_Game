//
//  Game.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 30/10/2020.
//

import Foundation

class Game {
    private var championList : [Champion] = [Necromancer(), Monk(), DemonHunter(), Wizzard(), Crusader(), Barbarian()]
    private var player1 : Player = Player(name: "Player1")
    private var player2 : Player = Player(name: "Player2")
    private var round : Int = 1
    private var legendaryWeapons = [Gungnir(), Trisula(), Mjöllnir()]
    
    
    // Welcoming players and choosing a personalized name
    private func hello(player: Player) -> String {
        print("\nHello \(player.name) ! What's your name ?")
        while let summonerName = readLine() {
            if summonerName.trimmingCharacters(in: .whitespaces) != "" && summonerName != player1.name && summonerName != player2.name {
                return summonerName
            } else {
                print("⚠️ Sorry this is not a valid name, or this name is already taken. Please \(player.name) choose another name.")
            }
        }
        return ""
    }
    
    
    
    // Algo that checks if the name chosen for each character is free.
    private func isChampionNameAvailable(userName: String) -> Bool {
        if self.player1.team.contains(where: {$0.name == userName}) || self.player2.team.contains(where: {$0.name == userName}) || userName == "" {
            return false
        }
        return true
    }
    
    // Create a champion copy with a new name
    private func createChampion(category: Role) -> Champion? {
        var result : Champion?
        if let line = readLine(), let prompt = Int(line) {
            if let champion = self.championList.first(where: {$0.index == prompt}) {
                if champion.category == category {
                    while result == nil {
                        print("\nWhat name would you give to your \(champion.name) ?")
                        if let promptUserName = readLine() {
                            if self.isChampionNameAvailable(userName: promptUserName) {
                                result = champion.copy()
                                result?.name = promptUserName
                            } else {
                                print("\n⚠️ This name \(promptUserName) is not available or you enter a bad name ⚠️, try again.\n")
                            }
                        }
                    }
                } else {
                    print(" \n⚠️ This champion \(champion.name) is not a \(category), it's a \(champion.category) ⚠️\n")
                }
            } else {
                print("\n⚠️ Unknow champion with index \(prompt), ⚠️ try again.\n")
            }
        } else {
            print("\n⚠️ This is not a valid choice. You have to type the index of the champion. Try again. ⚠️")
        }
        return result
    }
    
    
    // Add the champion created previously in the table of player
    private func promptChampion(_ player: Player, category: Role) {
        var champion: Champion?
        while champion == nil {
            print("\nType the index of the \(category) you want on your team.")
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
    
    // Calculate if team have 3 dead champions game is over.
    private func isEndGame() -> Bool {
        if self.player1.team.isEmpty || self.player2.team.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // Decide who start between 2 players.
    private func whoStart() -> (Player, Player) {
        var alea = [game.player1, game.player2]
        alea.shuffle()
        print("🎲🎲🎲 Chance will decide who will strike the first blood ! 🎲🎲🎲\n")
        print("________________________________________________________________________________")
        print("\(String(describing: alea.first!.name)) begin.\n")
        return (alea.first!, alea.last!)
    }
    
    // Magic chest 3/10 chances to pop-up with four random surprise.
    private func magicChest(champion: Champion) {
        let randomAppear = Int.random(in: 1...10)
        let randomContent = Int.random(in: 1...4)
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
                print("🍴🍴🍴 You found a new weapon : A fork !! Better than nothing.. Your power is now to 5 damage. 🍴🍴🍴 ")
                if champion.category == .heal {
                    print("\nSorry, this weapon is not for heal, maybe more luck next time 🤪 ")
                } else {
                    champion.weapon = Fork()
                }
            case 3:
                print("⚔️⚔️⚔️ You found a new weapon: Trisula! with power of 40 and heal 30! ⚔️⚔️⚔️\n")
                if champion.category == .heal {
                    champion.weapon = Trisula()
                } else {
                    print("\nSorry, this weapon is only for heal, maybe more luck next time 🤪 ")
                }
            case 4:
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
    
    // Ask to the current player : "select 1 for attack or 2 for heal"
    private func selectAnAction(playerAttacker: Player, playerTarget: Player) {
        var selectAction = ""
        while selectAction != "1" && selectAction != "2" {
            if playerAttacker.team.contains(where: {$0.category == .heal}) {
                print("\(playerAttacker.name) do you want to ?\n 1. Attack an ennemy team\n 2. Heal one of your mates")
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
    }
    
    // Game logic with selection of two champion "playingChampion" and "Target" and logic of the selected action (heal or attack).
    private func action(selectAction: String, playerAttacker: Player, playerTarget: Player) {
        var finishAction = false
        
        while finishAction == false {
            print("Which champion will play ?")
            if let prompt = readLine(), let intPrompt = Int(prompt) {
                if let playingChampion = playerAttacker.team.first(where: {$0.index == intPrompt}) {
                    
                    
                    if selectAction == "1" {
                        magicChest(champion: playingChampion)
                        while finishAction == false {
                            print("Which champion will suffer your attack ?")
                            let prompt = Int(readLine() ?? "")
                            if let target = playerTarget.team.first(where: {$0.index == prompt}) {
                                playingChampion.attack(target: target)
                                finishAction = true
                                if target.isAlive() {
                                    print("\(target.name) suffered \(playingChampion.weapon.weaponDamage) damage, he now has \(target.life) points of life.\n")
                                } else {
                                    target.life = 0
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
                            print("Which champion need to be healed ?")
                            let prompt = Int(readLine() ?? "")
                            if let target = playerAttacker.team.first(where: {$0.index == prompt}) {
                                if target.life < target.maxLife {
                                    playingChampion.heal(target: target)
                                    finishAction = true
                                    print("\(target.name) has been healed, he now has \(target.life)points of life")
                                }
                                else {
                                    print("⚠️ Sorry this champion is full HP, you can't heal him. ⚠️")
                                    finishAction = true
                                    selectAnAction(playerAttacker: playerAttacker, playerTarget: playerTarget)
                                }
                            }
                            else {
                                print("⚠️ Sorry you can't heal this champion. ⚠️")
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
    private func play() {
        let whoStart = self.whoStart()
        var playerAttacker = whoStart.0
        var playerTarget = whoStart.1
        
        while self.isEndGame() == false {
            print("\nRound n°\(round)\n")
            print("\n\(playerAttacker.name)'s team : \n")
            Output.tablePrint()
            Output.printChampionList(champions: playerAttacker.team)
            print("_____________________________________________________\n")
            print("\n\(playerTarget.name)'s team :")
            Output.tablePrint()
            Output.printChampionList(champions: playerTarget.team)
            selectAnAction(playerAttacker: playerAttacker, playerTarget: playerTarget)
            swap(&playerAttacker , &playerTarget)
            self.round += 1
        }
    }
    
    
    // Print the statistics of end game.
    private func printStats() {
        if let winner = [self.player1, self.player2].first(where: {!$0.team.isEmpty}), let looser = [self.player1, self.player2].first(where: {$0.team.isEmpty}) {
            Output.victoryPrint()
            print("🥇🥇🥇 YAY!  \(winner.name) won the game  in \(self.round) rounds. 🥇🥇🥇")
            print("Here was the team of \(winner.name)")
            Output.tablePrint()
            for champions in winner.championStat {
                print("\(champions.index).         \(champions.name)                       \(champions.category)                 \(champions.life)/\(champions.maxLife)HP                  \(champions.weapon.weaponName)                  \(champions.weapon.weaponDamage) dmg\n")
            }
            print("Here was the team of \(looser.name)")
            Output.tablePrint()
            for champions in looser.championStat {
                print("\(champions.index).         \(champions.name)                       \(champions.category)                 \(champions.life)/\(champions.maxLife)HP                  \(champions.weapon.weaponName)                  \(champions.weapon.weaponDamage) dmg\n")
            }
        }
    }
    
    
    // Starting game.
    func start() {
        Output.welcomePrint()
        
        self.player1.name = self.hello(player: self.player1)
        self.player2.name = self.hello(player: self.player2)
        
        Output.championSelectPrint()
        print("\n \(self.player1.name) you have too choose 3 champions 🧙🏼‍♀️🧟‍♀️🧝🏾 in your team, 1 heal, 1 tank and 1 DPS in the following list.\n")
        Output.tablePrint()
        
        Output.self.printChampionList(champions: self.championList)
        self.promptChampion(self.player1, category: .tank)
        self.promptChampion(self.player1, category: .heal)
        self.promptChampion(self.player1, category: .DPS)
        
        print("\n\(self.player2.name) is your turn to select a team!\n You have too choose 3 champions 🧙🏼‍♀️🧟‍♀️🧝🏾 in your team, 1 heal, 1 tank and 1 DPS in the following list.\n")
        Output.tablePrint()
        
        Output.self.printChampionList(champions: self.championList)
        self.promptChampion(self.player2, category: .tank)
        self.promptChampion(self.player2, category: .heal)
        self.promptChampion(self.player2, category: .DPS)
        print("\nSuper! Teams are ready, let's GO!\n")
        
        Output.fightPrint()
        
        self.play()
        self.printStats()
    }
    
    
    
}

