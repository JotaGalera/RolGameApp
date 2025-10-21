//
//  PlayerModel.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 20/10/25.
//

import Foundation

struct PlayerModel {
    let name: String
    let classType: ClassType
    let maxHealth: Int
    let currentHealth: Int
    let maxLives: Int
    let currentLives: Int
    var damage: Int
    
    init(name: String, classType: ClassType, maxHealth: Int, maxLives: Int, damage: Int) {
        self.name = name
        self.classType = classType
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth
        self.maxLives = maxLives
        self.currentLives = maxLives
        self.damage = damage
    }
    
    private init(name: String, classType: ClassType, maxHealth: Int, currentHealth: Int, maxLives: Int, currentLives: Int, damage: Int) {
        self.name = name
        self.classType = classType
        self.maxHealth = maxHealth
        self.currentHealth = currentHealth
        self.maxLives = maxLives
        self.currentLives = maxLives
        self.damage = damage
    }
    
    func updateHealth(amount: Int) -> PlayerModel {
        return PlayerModel(name: name,
                           classType: classType,
                           maxHealth: maxHealth,
                           currentHealth: max(currentHealth - amount, 0),
                           maxLives: maxLives,
                           currentLives: currentLives,
                           damage: damage)
    }
}
