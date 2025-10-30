//
//  Combat.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 3/10/25.
//

import Foundation

struct Combat {
    let player: Player
    let boss: Boss
    let turnManager: TurnManager
    
    init(player: Player, boss: Boss) {
        self.player = player
        self.boss = boss
        self.turnManager = TurnManagerImplementation(player: player, boss: boss)
    }
    
    func nextTurn() -> Turn {
        turnManager.nextTurn()
    }

    func getCurrentTurn() -> Turn {
        turnManager.getCurrentTurn()
    }
}


