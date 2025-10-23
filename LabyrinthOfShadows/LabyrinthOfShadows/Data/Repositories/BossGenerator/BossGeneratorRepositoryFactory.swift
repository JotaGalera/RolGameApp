//
//  BossGeneratorRepositoryFactory.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 23/10/25.
//

import Foundation

enum BossGeneratorRepositoryFactory {
    static func make() -> BossGeneratorRepository {
        return BossGeneratorRepositoryImplementation(generatorDataSource: BossDataSourceImplementation())
    }
}
