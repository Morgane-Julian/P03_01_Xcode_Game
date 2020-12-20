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
    
    
    // Accueil des joueurs et choix d'un nom personnalisé pour chacun
    func hello(player: Player) -> String {
        print("\nHello \(player.name) ! What's your name ?")
        while let summonerName = readLine() {
            if summonerName != "" {
            return summonerName
            } else {
                print("Sorry this is not a valid name, \(player.name). Please enter your name.")
            }
        }
        return ""
    }
        

    
    // Algo qui vérifie que le nom choisi pour chaque personnage n'est pas déjà pris
    func isChampionNameAvailable(userName: String) -> Bool {
        if self.player1.team.contains(where: {$0.name == userName}) || self.player2.team.contains(where: {$0.name == userName}) {
            return false
        }
        return true
    }
    
    // 
    func createChampion(category: Role) -> Champion? {
        var result : Champion?
        if let line = readLine(), let prompt = Int(line) {
            if let champion = self.championList.first(where: {$0.index == prompt}) {
                if champion.category == category {
                    print("\nQuel nom souhaitez vous pour le \(champion.name) ?")
                    if let promptUserName = readLine() {
                        if self.isChampionNameAvailable(userName: promptUserName) {
                            result = champion.copy()
                            result?.name = promptUserName
                        } else {
                            print("\n⚠️ This name \(promptUserName) is not available ⚠️, try again.\n")
                        }
                    }
                } else {
                    print(" \n⚠️ This champion \(champion.name) is not a \(category), it's a \(champion.category) ⚠️\n")
                }
            } else {
                print("\n⚠️ Unknow champion with index \(prompt), ⚠️ try again.\n")
            }
        } else {
            print("\nThis is not a valid choice. Try again.")
        }
        return result
    }
    
    
    
    // Ajoute le champion sélectionné précédemment, dans le tableau de sélection du joueur passé en paramètre.
    func promptChampion(_ player: Player, category: Role) {
        var champion: Champion?
        while champion == nil {
            print("\nWitch \(category) would you select in your team ?")
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
    
    
    
    // Print list of champions enable for champion select or game.
    func printChampionList(champions: [Champion]) {
        for champion in champions {
            print("\(champion.index).               \(champion.name)               \(champion.category)                \(champion.life)HP               \(champion.weapon.weaponName)                      \(champion.weapon.weaponDamage) dmg.\n")
        }
    }
    
    // Game continue ? Calculate if team have 3 dead champions it's over.
    func isEndGame() -> Bool {
        if self.player1.team.isEmpty || self.player2.team.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // decide who start
    func whoStart() -> (Player, Player) {
        var alea = [game.player1, game.player2]
        alea.shuffle()
        print("🎲 Chance will decide who will strike the first blood ! 🎲\n")
        print("___________________________________________________")
        print("\(String(describing: alea.first!.name)) begin.\n")
        return (alea.first!, alea.last!)
    }
    
    func magicChest(champion: Champion) {
        let randomAppear = Int.random(in: 1...10)
        let randomContent = Int.random(in: 1...5)
        if randomAppear == 2 || randomAppear == 6 || randomAppear == 9 {
            print("A Chest just popped up !!")
            print("")
            print("")
            print("You're opening the chest....")
            print("")
            print("")
            
            switch randomContent {
            case 1:
                print("You found a new weapon : Gungnir!! You got the power of Odin : 70 damage!")
                champion.weapon = Gungnir()
            case 2:
                print("The chest was empty")
            case 3:
                print("You found a new weapon: Trisula! with power of 30 and heal 40!")
                if champion.category == .heal {
                    champion.weapon = Trisula()
                } else {
                    print("Sorry, this weapon is only for heal, maybe more luck next time 🤪 ")
                }
            case 4:
                print("BBBOOOOOOOOMMM !!!  There was a bomb in the chest, you lose 15 points of life")
                champion.life -= 10
            case 5:
                print("You found a new weapon: Mjöllnir with a power of 50 !! ")
                champion.weapon = Mjöllnir()
            default: print("error")
            }
            print("*************************************************")
        }
    }
    

    
    func action(selectAction: String, playerAttacker: Player, playerTarget: Player) {
        // le joueur à choisit une action dans play, on lui demande quel champion va jouer peut importe son choix sur attack ou heal
        print("Quel champion va jouer ")
        if let prompt = readLine(), let intPrompt = Int(prompt) {
            if let playingChampion = playerAttacker.team.first(where: {$0.index == intPrompt}) {
                magicChest(champion: playingChampion)
         
                // s'il a choisit 1 (attack) on rentre ici
                if selectAction == "1" {
                    print("Quel champ on attaque ?")
                    let prompt = Int(readLine() ?? "")
                    if let target = playerTarget.team.first(where: {$0.index == prompt}) {
                        playingChampion.attack(target: target)
                        if target.isAlive() {
                            print("\(target.name) à subit \(playingChampion.weapon.weaponDamage) dégâts il lui reste \(target.life) points de vie\n")
                        } else {
                            print(" ⚠️ Warning \(target.name) is dead !! ☠️\n")
                            print("☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️\n")
                            if let iD = playerTarget.team.firstIndex(of: target) {
                                playerTarget.team.remove(at: iD)
                            }
                        }
                    }
                }
                // s'il à choisit 2 heal on rentre là
                else if selectAction == "2", playingChampion.category == .heal {
                    print("Quel champ on soigne ?")
                    let prompt = Int(readLine() ?? "")
                    if let target = playerAttacker.team.first(where: {$0.index == prompt}) {
                        playingChampion.heal(target: target)
                        print("\(target.name) won \(playingChampion.weapon.heal)pts of life, he now got \(target.life)pts of life")
                    }
                } else {
                    print("Sorry, this is not valid, you chose healing you have to choose a heal champion.")
                }
            } else { print("Sorry, this champion is not in the list, try again.")
                
            }
        }
    }


    func play() {
        
        // Appel de whoStart pour définir qui commence
        let whoStart = self.whoStart()
        var playerAttacker = whoStart.0
        var playerTarget = whoStart.1
        // Debut de round, print les tableau de champions
        while self.isEndGame() == false {
            print("\nRound n°\(round)")
            print("\nVoici la team de \(playerAttacker.name)\n")
            printChampionList(champions: playerAttacker.team)
            print("_____________________________________________________\n")
            print("\nVoici la team de \(playerTarget.name)")
            printChampionList(champions: playerTarget.team)
            // Ask action
            var selectAction = ""
            while selectAction == "" {
            if playerAttacker.team.contains(where: {$0.category == .heal}) {
                print("\(playerAttacker.name) do you want to ?\n 1. Attack an ennemy team\n 2. Heal one of your mates")
                selectAction = readLine() ?? ""
                // Appel de action() en fonction du choix fait précédemment
                self.action(selectAction: selectAction, playerAttacker: playerAttacker, playerTarget: playerTarget)
            } else {
                print("Sorry, your heal is dead you can't do this")
            }
            }
            // Fin du round on incrémente round de 1 et on swap playerAttacker et playerTarget
            swap(&playerAttacker , &playerTarget)
            self.round += 1
        }
    }
    
    
    
    
    
    
    
    // Affichage des stats de fin de partie
    func printStats() {
        if let winner = [self.player1, self.player2].first(where: {!$0.team.isEmpty}), let looser = [self.player1, self.player2].first(where: {$0.team.isEmpty}) {
            print("youpi \(winner.name) a gagné")
            print("Game end in \(self.round)")
            printChampionList(champions: winner.championStat)
            printChampionList(champions: looser.championStat)
        }
    }
    


}

