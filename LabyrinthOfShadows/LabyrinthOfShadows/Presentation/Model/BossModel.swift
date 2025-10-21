//
//  BossModel.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 20/10/25.
//

import Foundation

struct BossModel {
    let name: String
    let abilities: [String]
    let description: String
    let maxHealth: Int
    let currentHealth: Int
    let damage: Int
    
    init(name: String, abilities: [String], description: String, maxHealth: Int, damage: Int) {
        self.name = name
        self.abilities = abilities
        self.description = description
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth
        self.damage = damage
    }
    
    private init(name: String, abilities: [String], description: String, maxHealth: Int, currentHealth: Int, damage: Int) {
        self.name = name
        self.abilities = abilities
        self.description = description
        self.maxHealth = maxHealth
        self.currentHealth = currentHealth
        self.damage = damage
    }
    
    func updateHealth(amount: Int) -> BossModel {
        return BossModel(name: name,
                         abilities: abilities,
                         description: description,
                         maxHealth: maxHealth,
                         currentHealth: max(currentHealth - amount, 0),
                         damage: damage)
    }
}
