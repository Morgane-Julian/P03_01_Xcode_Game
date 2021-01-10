//
//  Players.swift
//  P03_01_Xcode_Game
//
//  Created by Symbioz on 30/10/2020.
//

import Foundation

class Player {
    var team = [Champion]() // Table of champions selected by the player
    var championStat = [Champion]() // A copy of the team table for prints the statistics in end game
    var name : String
    
    
    init(name: String) {
        self.name = name
    }
    
    
}



