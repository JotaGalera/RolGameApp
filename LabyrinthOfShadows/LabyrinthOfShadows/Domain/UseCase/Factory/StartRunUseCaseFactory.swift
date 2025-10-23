//
//  StartRunUseCaseFactory.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 23/10/25.
//

import Foundation

enum StartRunUseCaseFactory {
    static func make() -> StartRunUseCase {
        return StartRunUseCaseImplementation(bossGenerator: BossGeneratorRepositoryFactory.make())
    }
}
