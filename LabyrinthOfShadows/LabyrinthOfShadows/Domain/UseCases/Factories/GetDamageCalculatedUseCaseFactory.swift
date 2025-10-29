//
//  GetDamageCalculatedUseCaseFactory.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 29/10/25.
//

import Foundation

enum GetDamageCalculatedUseCaseFactory {
    static func make() -> GetDamageCalculatedUseCase {
        return GetDamageCalculatedUseCaseImplementation()
    }
}
