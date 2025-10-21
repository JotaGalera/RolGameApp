//
//  Player.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 3/10/25.
//

import Foundation

struct Player {
    let name: String
    let classType: ClassType
    var stats: [Stats: Int]
    var lives = 3
    
    func convertToPresentationModel() -> PlayerModel {
        var damage = 0
        
        switch classType {
        case .warrior:
            damage = stats[.strength] ?? 0
        case .thief:
            damage = stats[.dexterity] ?? 0
        case .mage:
            damage = stats[.intelligence] ?? 0
        }
        
        return PlayerModel(name: name,
                           classType: classType,
                           maxHealth: stats[.health] ?? 0,
                           maxLives: lives,
                           damage: damage)
    }
}

enum ClassType {
    case warrior, thief, mage
}
