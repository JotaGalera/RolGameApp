//
//  BossGeneratorImplementation.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import Foundation

struct BossGeneratorRepositoryImplementation: BossGeneratorRepository {
    private let generatorDataSource: BossDataSource
    
    init(generatorDataSource: BossDataSource) {
        self.generatorDataSource = generatorDataSource
    }
    
    func getBosses(prompt: String) async throws -> Boss {
        return try await generatorDataSource.generateBoss(prompt: prompt)
    }
}
