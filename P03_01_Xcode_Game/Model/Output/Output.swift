//
//  Output.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 18/12/2020.
//

import Foundation

class Output {
    
    static func welcomePrint() {
        print("Welcome to..")
        print("""
        _______  _     _  _______  ______    ______     _______  _______  __    _  _______  __   __  _______  _______  _______
       |       || | _ | ||       ||    _ |  |      |   |       ||       ||  |  | ||       ||  | |  ||       ||       ||       |
       |  _____|| || || ||   _   ||   | ||  |  _    |  |       ||   _   ||   |_| ||   _   ||  | |  ||    ___||  _____||_     _|
       | |_____ |       ||  | |  ||   |_||_ | | |   |  |       ||  | |  ||       ||  | |  ||  |_|  ||   |___ | |_____   |   |
       |_____  ||       ||  |_|  ||    __  || |_|   |  |      _||  |_|  ||  _    ||  |_|  ||       ||    ___||_____  |  |   |
        _____| ||   _   ||       ||   |  | ||       |  |     |_ |       || | |   ||      | |       ||   |___  _____| |  |   |
       |_______||__| |__||_______||___|  |_||______|   |_______||_______||_|  |__||____||_||_______||_______||_______|  |___|
""")
    }
    
    
    static func championSelectPrint() {
        print("""

     *************************************************************************************************************************

     ******************************************⚔️⚔️   CHAMPION SELECT   ⚔️⚔️  ***********************************************

      *************************************************************************************************************************
    """)
    }
    
    
    static func tablePrint() {
        print("*************************************************************************************************************************")
        print("N°------------Name-----------------------Role-----------------Life Points------------------Weapon-----------------Damage")
        print("*************************************************************************************************************************")
    }
    
    // Print the list of champions available (for champion select or game..)
    static func printChampionList(champions: [Champion]) {
        for champion in champions {
            print("\(champion.index).         \(champion.name)                       \(champion.category)                 \(champion.life)/\(champion.maxLife)HP                  \(champion.weapon.weaponName)                  \(champion.weapon.weaponDamage) dmg\n")
        }
    }
    
    
    
    static func fightPrint() {
        print("""

            ************************************************************************************************************************

            ******************************************⚔️⚔️       LET'S FIGHT    ⚔️⚔️***********************************************

             ***********************************************************************************************************************\n
    """)
    }
    
    static func victoryPrint() {
        print("""
 __   __  ___   _______  _______  _______  ______    __   __
|  | |  ||   | |       ||       ||       ||    _ |  |  | |  |
|  |_|  ||   | |       ||_     _||   _   ||   | ||  |  |_|  |
|       ||   | |       |  |   |  |  | |  ||   |_||_ |       |
|       ||   | |      _|  |   |  |  |_|  ||    __  ||_     _|
 |     | |   | |     |_   |   |  |       ||   |  | |  |   |
  |___|  |___| |_______|  |___|  |_______||___|  |_|  |___|
""")
        
    }
}
