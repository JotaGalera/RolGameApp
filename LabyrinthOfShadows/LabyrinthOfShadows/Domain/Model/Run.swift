//
//  Run.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 3/10/25.
//

import Foundation

struct Run {
    var combats: [Combat]
    var currentCombatIndex: Int
    var playerIsDead: Bool {
        combats.last?.player.lives == 0
    }
    var isFinished: Bool {
        currentCombatIndex >= combats.count || playerIsDead
    }
}
