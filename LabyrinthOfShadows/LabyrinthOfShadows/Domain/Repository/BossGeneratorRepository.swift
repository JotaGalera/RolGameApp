//
//  BossGeneratorRepository.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import Foundation

protocol BossGeneratorRepository {
    func getBosses(prompt: String) async throws -> Boss
}
