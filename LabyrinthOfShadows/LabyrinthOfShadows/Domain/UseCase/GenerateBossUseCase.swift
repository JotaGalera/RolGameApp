//
//  GenerateBossUseCase.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 16/9/25.
//

import Foundation

protocol GenerateBossUseCase {
    func callAsFunction() async throws -> Boss
}

struct GenerateBossUseCaseImplementation: GenerateBossUseCase {
    let repository: BossRepository
    
    init(repository: BossRepository) {
        self.repository = repository
    }
    
    func callAsFunction() async throws -> Boss {
        let examplePrompt = "A gigantic shadow dragon that feeds on fear and rules over an ancient underground labyrinth."
        
        return try await repository.getBosses(prompt: examplePrompt)
    }
}
