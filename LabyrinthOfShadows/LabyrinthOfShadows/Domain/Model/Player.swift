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
}

enum ClassType {
    case warrior, thief, mage
}
