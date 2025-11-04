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
        self.currentLives = currentLives
        self.damage = damage
    }
    
    func updateHealth(amount: Int) -> PlayerModel {
        let newHealth = currentHealth - amount
        
        if newHealth > 0 {
            return PlayerModel(name: name,
                               classType: classType,
                               maxHealth: maxHealth,
                               currentHealth: newHealth,
                               maxLives: maxLives,
                               currentLives: currentLives,
                               damage: damage)
        } else {
            return PlayerModel(name: name,
                                     classType: classType,
                                     maxHealth: maxHealth,
                                     currentHealth: maxHealth,
                                     maxLives: maxLives,
                                     currentLives: max(currentLives - 1, 0),
                                     damage: damage)
        }
    }
    
    func convertToDomain() -> Player {
        Player(name: name,
               classType: classType,
               stats: [.health: currentLives],
               lives: currentLives)
    }
}
