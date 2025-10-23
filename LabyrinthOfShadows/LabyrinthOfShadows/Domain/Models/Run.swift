//
//  Run.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 3/10/25.
//

import Foundation

struct Run {
    var combats: [Combat]
    
    private(set) var currentCombatIndex: Int
    
    var playerIsDead: Bool {
        combats.last?.player.lives == 0
    }
    var isPlayerWinner: Bool {
        currentCombatIndex >= combats.count && !playerIsDead
    }
    var isPlayerLost: Bool {
        playerIsDead
    }
    
    func getCurrentCombat () -> Combat? {
        return combats[currentCombatIndex]
    }
    
    mutating func nextCombat () -> Combat? {
        currentCombatIndex += 1
        
        guard !isPlayerWinner, !isPlayerLost, currentCombatIndex < combats.count else { return nil }
        
        return combats[currentCombatIndex]
    }
}
