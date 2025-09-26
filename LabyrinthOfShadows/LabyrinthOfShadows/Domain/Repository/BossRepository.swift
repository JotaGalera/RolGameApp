//
//  BossRepository.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import Foundation

protocol BossRepository {
    func getBosses(prompt: String) async throws -> Boss
}
