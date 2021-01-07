//
//  Hunter.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 02/11/2020.
//

import Foundation

class DemonHunter : Champion {
    
    init() {
        super.init(index: 3, name: "Demon Hunter", life: 90, category: .DPS, weapon: Knife(), maxLife: 90)
    }
}



