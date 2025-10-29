//
//  GetDamageCalculated.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 29/10/25.
//

import Foundation

protocol GetDamageCalculatedUseCase: AutoMockable {
    func callAsFunction(for damage: Int) -> Int
}

struct GetDamageCalculatedUseCaseImplementation: GetDamageCalculatedUseCase {
    func callAsFunction(for damage: Int) -> Int {
        1 + (damage / 5)
    }
}
