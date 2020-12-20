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
    
    init(index: Int, name: String, life: Int, category: Role, weapon: Weapon) {
        self.name = name
        self.life = life
        self.category = category
        self.weapon = weapon
        self.index = index
    }
    
    // Copie l'original pour le placer dans le tableau de championSelect du joueur
    func copy() -> Champion {
        return Champion(index: self.index, name: self.name, life: self.life, category: self.category, weapon: self.weapon)
    }
    
    
    // Détermine si le champion est vivant
    func isAlive() -> Bool {
        if self.life <= 0 {
            return false
        } else {
            return true
        }
    }
    
    // Fonction calcul du heal
    func heal(target: Champion) {
        target.life = target.life + self.weapon.heal
    }
    
    // Fonct calcul de l'attaque
    func attack(target: Champion) {
        target.life = target.life - self.weapon.weaponDamage
    }

}
