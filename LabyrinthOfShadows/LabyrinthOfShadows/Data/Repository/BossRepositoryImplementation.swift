//
//  BossRepositoryImplementation.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import Foundation

class BossRepositoryImplementation: BossRepository {
    let generatorDataSource: AIServiceDataSource
    
    init(generatorDataSource: AIServiceDataSource) {
        self.generatorDataSource = generatorDataSource
    }
    
    func getBosses() async throws -> [Boss] {
        let textGenerationAIResult = generatorDataSource
        
        // Parse text to Domain
        return [Boss(name: "Unknown", abilities: ["Default attack"], stats: [.health : 100, .strength : 10, .agility : 10, .intelligence : 10, .luck : 10, .dexterity : 10], description: "Stupid default boss")]
    }
}
