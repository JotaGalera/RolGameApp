//
//  CheckVictoryConditionUseCaseFactory.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 23/10/25.
//

import Foundation

enum CheckVictoryConditionUseCaseFactory {
    static func make() -> CheckCombatVictoryConditionUseCase {
        return CheckCombatVictoryConditionUseCaseImplementation()
    }
}
