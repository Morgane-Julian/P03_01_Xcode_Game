//
//  Champion.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 30/10/2020.
//

import Foundation

enum Role: Int {
    case heal = 1
    case tank = 2
    case DPS = 3
    
}


class Champion: Equatable {
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        return lhs.index == rhs.index
    }
    
    var name: String
    var life: Int
    var weapon: Weapon
    var category: Role
    var index: Int
    var maxLife: Int
    
    init(index: Int, name: String, life: Int, category: Role, weapon: Weapon, maxLife: Int) {
        self.name = name
        self.life = life
        self.category = category
        self.weapon = weapon
        self.index = index
        self.maxLife = maxLife
    }
    
    // Copy the original champion (to place it in the team table of the current player)
    func copy() -> Champion {
        return Champion(index: self.index, name: self.name, life: self.life, category: self.category, weapon: self.weapon, maxLife: self.maxLife)
    }
    
    
    // Determine if the champion is alive
    func isAlive() -> Bool {
        if self.life <= 0 {
            return false
        } else {
            return true
        }
    }
    
    // heal calculation
    func heal(target: Champion) {
        let healing: Int = weapon.weaponDamage
        if target.life + healing >= target.maxLife {
            target.life = target.maxLife
        } else {
            target.life += healing
        }
    }
    
    // attack calculation
    func attack(target: Champion) {
            target.life = target.life - self.weapon.weaponDamage
        }
    
}
