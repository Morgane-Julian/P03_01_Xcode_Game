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
            }
        }
        return ""
    }
    
    // Algo qui vérifie que le nom choisi pour chaque personnage n'est pas déjà pris
    func isChampionNameAvailable(userName: String) -> Bool {
        if self.player1.championSelected.contains(where: {$0.name == userName}) || self.player2.championSelected.contains(where: {$0.name == userName}) {
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
                print("\n⚠️ Unknow champion with name \(prompt), ⚠️ try again.\n")
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
                player.championSelected.append(c)
                print("\nYou choose \(c.name) for \(category).\n")
                player.championStat.append(c)
                if let index = player.championSelected.lastIndex(of: c) {
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
        if self.player1.championSelected.isEmpty || self.player2.championSelected.isEmpty {
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

   
    func play() {
           let whoStart = self.whoStart()
           var playerAttacker = whoStart.0
           var playerTarget = whoStart.1
           
           while self.isEndGame() == false {
               print("\nRound n°\(round)")
               print("\nVoici la team de \(playerAttacker.name)\n")
               printChampionList(champions: playerAttacker.championSelected)
               print("_____________________________________________________\n")
               print("\nVoici la team de \(playerTarget.name)")
               printChampionList(champions: playerTarget.championSelected)
               var selectAction = "1"
               if playerAttacker.championSelected.contains(where: {$0.category == .heal }) {
                   print("\(playerAttacker.name) do u want to\n 1.Attack an enemy team\n 2.Heal one of your mates ?")
                   selectAction = readLine() ?? ""
               }
               if selectAction == "1" {  // le joueur choisit d'attaquer
                   print("\(playerAttacker.name) please select a champion for Attack\n")
                   var prompt = Int(readLine() ?? "")
                   // prompt récupère la valeur de readLine en tant qu'Int
                   if let championAttacker = playerAttacker.championSelected.first(where: {$0.index == prompt}) {
                       //On a trouvé le champion correspondant
                       magicChest(champion: championAttacker)
                       var championTarget: Champion? = nil
                       while championTarget == nil {
                           print("Quel champion souhaitez vous attaquer ?\n")
                           prompt = Int(readLine() ?? "")
                           championTarget = playerTarget.championSelected.first(where: {$0.index == prompt})
                           if championTarget != nil {
                               //On a trouvé le champion correspondant
                               championTarget!.life = championTarget!.life - championAttacker.weapon.weaponDamage
                               if championTarget!.isAlive() {
                                   print("\(championTarget!.name) à subit \(championAttacker.weapon.weaponDamage) dégâts il lui reste \(championTarget!.life) points de vie\n")
                               } else {
                                   print(" ⚠️ Warning \(championTarget!.name) is dead !! ☠️\n")
                                   print("☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️\n")
                                   if let iD = playerTarget.championSelected.firstIndex(of: championTarget!) {
                                       playerTarget.championSelected.remove(at: iD)
                                   }
                               }
                               swap(&playerAttacker , &playerTarget)
                               self.round += 1
                           } else {
                               print("⚠️ Choix incorrect veuillez recommencer ⚠️\n")
                           }
                       }
                   } else {
                       print("Choix incorrect veuillez recommencer\n")
                   }
               } else if selectAction == "2" { // Le joueur choisit de soigner
                   print("\(playerAttacker.name) please select a champion for heal\n")
                   var prompt = Int(readLine() ?? "")        // prompt récupère la valeur de readLine en tant qu'Int
                   if let championAttacker = playerAttacker.championSelected.first(where: {$0.index == prompt}), championAttacker.category == .heal {
                       //On a trouvé le champion correspondant
                       //Je vérifie que ça soit bien un heal
                       magicChest(champion: championAttacker)
                       print("Quel champion souhaitez vous soigner ?\n")
                       prompt = Int(readLine() ?? "")
                       if let healTarget = playerAttacker.championSelected.first(where: {$0.index == prompt}) {
                           //On a trouvé le champion correspondant
                           healTarget.life = healTarget.life + championAttacker.weapon.heal
                           print("\(healTarget.name) à été soigné de \(championAttacker.weapon.heal) points de vie, il à désormais \(healTarget.life) points de vie\n")
                       }
                       swap(&playerAttacker , &playerTarget)
                       self.round += 1
                   } else {
                       print("Choix incorrect ce champion n'est pas un heal veuillez recommencer\n")
                   }
               } else {
                   print("⚠️ Choix incorrect veuillez recommencer ⚠️\n")
               }
               
           }
       }

    
    
    
    // Affichage des stats de fin de partie
    func printStats() {
        if let winner = [self.player1, self.player2].first(where: {!$0.championSelected.isEmpty}) {
            print("youpi \(winner.name) a gagné")
            print("Game end in \(self.round)")
        }
        
        
    }
    


}

