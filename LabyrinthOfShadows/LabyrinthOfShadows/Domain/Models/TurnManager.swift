//
//  TurnManager.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 29/10/25.
//

import Foundation

protocol TurnManager: AutoMockable {
    func nextTurn() -> Turn
    func getCurrentTurn() -> Turn
}

enum Participant {
    case player
    case boss
}

struct Turn {
    let participant: Participant
}

class TurnManagerImplementation: TurnManager {
    private var player: Player
    private var boss: Boss
    private(set) var currentTurnIndex: Int = 0
    
    private var turnOrder: [Turn] {
        let playerAgility = player.stats[.agility] ?? 0
        let bossAgility = boss.stats[.agility] ?? 0
        
        var order: [Turn] = []
        
        if playerAgility == bossAgility {
            order = [Turn(participant: .player),
                     Turn(participant: .boss)]
        } else if playerAgility > bossAgility {
            let diff = playerAgility - bossAgility
            let extraTurns = diff / 10
            order.append(contentsOf: Array(repeating: Turn(participant: .player), count: 1 + extraTurns))
            order.append(Turn(participant: .boss))
        } else {
            let diff = bossAgility - playerAgility
            let extraTurns = diff / 10
            order.append(contentsOf: Array(repeating: Turn(participant: .boss), count: 1 + extraTurns))
            order.append(Turn(participant: .player))
        }
        
        return order
    }
    
    init(player: Player, boss: Boss) {
        self.player = player
        self.boss = boss
    }
    
    func nextTurn() -> Turn {
        currentTurnIndex = (currentTurnIndex + 1) % turnOrder.count
        let turn = turnOrder[currentTurnIndex]
        return turn
    }
    
    func getCurrentTurn() -> Turn { 
        turnOrder[currentTurnIndex]
    }
}
