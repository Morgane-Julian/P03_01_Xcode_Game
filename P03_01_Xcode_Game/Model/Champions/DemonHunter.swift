//
//  Hunter.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 02/11/2020.
//

import Foundation

class DemonHunter : Champion {
    
    init() {
        super.init(name: "demon hunter", life: 100, category: .DPS, weapon: Crossbow())
    }
 }



