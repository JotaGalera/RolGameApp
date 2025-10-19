//
//  Combat.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 3/10/25.
//

import Foundation

class Combat {
    var player: Player
    var boss: Boss
    private(set) var currentTurnIndex: Int = 0
    private var turnOrder: [Turn] {
        let playerAgility = player.stats[.agility] ?? 0
        let bossAgility = boss.stats[.agility] ?? 0
        
        var order: [Turn] = []
        
        if playerAgility == bossAgility {
            order = [Turn(participant: .player, action: .attack),
                     Turn(participant: .boss, action: .attack)]
        } else if playerAgility > bossAgility {
            let diff = playerAgility - bossAgility
            let extraTurns = diff / 10
            order.append(contentsOf: Array(repeating: Turn(participant: .player, action: .attack), count: 1 + extraTurns))
            order.append(Turn(participant: .boss, action: .attack))
        } else {
            let diff = bossAgility - playerAgility
            let extraTurns = diff / 10
            order.append(contentsOf: Array(repeating: Turn(participant: .boss, action: .attack), count: 1 + extraTurns))
            order.append(Turn(participant: .player, action: .attack))
        }
        
        return order
    }
    
    init(player: Player, boss: Boss) {
        self.player = player
        self.boss = boss
    }
    
    func nextTurn() -> Turn {
        let turn = turnOrder[currentTurnIndex]
        currentTurnIndex = (currentTurnIndex + 1) % turnOrder.count
        return turn
    }
}

enum Participant {
    case player
    case boss
}

struct Turn {
    let participant: Participant
    let action: Action
}

enum Action {
    case attack
}
