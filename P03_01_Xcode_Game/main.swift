//
//  main.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 30/10/2020.
//

import Foundation

var game = Game()

print("Welcome to Sword Conquest! ⚔️\n")

game.player1.name = game.hello(player: game.player1)
game.player2.name = game.hello(player: game.player2)



print("""

  *******************************************************************

  *****************  ⚔️⚔️   CHAMPION SELECT   ⚔️⚔️  *****************

  ********************************************************************
""")

print("\n \(game.player1.name) you have too choose 3 champions 🧙🏼‍♀️🧟‍♀️🧝🏾 in your team, 1 heal, 1 tank and 1 DPS in the following list.\n")
print("*************************************************************************************************************************")
print("Index----------------Name----------------Category----------------Life Points----------------Weapon----------------Damage")
print("*************************************************************************************************************************")

game.printChampionList(pChampions: game.championList)
game.promptChampions(game.player1)
print("\nSuper! Team is ready, let's GO!\n")


print("\n\(game.player2.name) is u turn to select a team!\n You have too choose 3 champions 🧙🏼‍♀️🧟‍♀️🧝🏾 in your team, 1 heal, 1 tank and 1 DPS in the following list.\n")
print("*************************************************************************************************************************")
print("Index----------------Name----------------Category----------------Life Points----------------Weapon----------------Damage")
print("*************************************************************************************************************************")

game.printChampionList(pChampions: game.championList)
game.promptChampions(game.player2)
print("\nSuper! Team is ready, let's GO!\n")


print("""

   ********************************************************************

   *****************  ⚔️⚔️   LET'S FIGHT !!!   ⚔️⚔️  *****************

   ********************************************************************
""")


game.play()
game.stats()









