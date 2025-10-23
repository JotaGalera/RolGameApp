//
//  CheckCombatVictoryConditionUseCase.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 23/10/25.
//

import Foundation

protocol CheckCombatVictoryConditionUseCase: AutoMockable {
    func callAsFunction(player: Player, boss: Boss) -> CombatVictoryCondition
}

enum CombatVictoryCondition {
    case ongoing
    case playerVictory
    case playerDefeat
}

struct CheckCombatVictoryConditionUseCaseImplementation: CheckCombatVictoryConditionUseCase {
    func callAsFunction(player: Player, boss: Boss) -> CombatVictoryCondition {
        let bossHealth = boss.stats[.health] ?? 0
        if bossHealth == 0 {
            return .playerVictory
        }
        
        if player.lives == 0 {
            return .playerDefeat
        }
        
        let playerHealth = player.stats[.health] ?? 0
        if playerHealth == 0 {
            if player.lives >= 1 {
                return .ongoing
            } else {
                return .playerDefeat
            }
        }
        
        return .ongoing
    }
}
