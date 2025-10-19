//
//  StartRunUseCase.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 19/10/25.
//

import Foundation

protocol StartRunUseCase {
    func callAsFunction(for player: Player) async throws -> Run
}

class StartRunUseCaseImplementation: StartRunUseCase {
    private let bossGenerator: BossRepository
    
    init(bossGenerator: BossRepository) {
        self.bossGenerator = bossGenerator
    }
    
    func callAsFunction(for player: Player) async throws -> Run {
        let prompt = buildBossPrompt(for: player, bossTheme: "A stone ogre infused with ancient earth magic.")
        let firstBoss = try await bossGenerator.getBosses(prompt: prompt)
        
        let firstCombat = Combat(player: player, boss: firstBoss)
        
        let run = Run(combats: [firstCombat], currentCombatIndex: 0)
        
        return run
    }
    
    private func buildBossPrompt(for player: Player, bossTheme: String) -> String {
        let prompt = """
        You are a procedural content generator for a turn-based RPG.

        Your goal is to create a balanced boss that follows the combat system below and is specifically designed to challenge the player without being unbeatable.

        ## Player Stats
        The player that will face the boss has the following attributes:
        - Class: \(player.classType)
        - Health: \(player.stats[.health] ?? 0)
        - Strength: \(player.stats[.strength] ?? 0)
        - Agility: \(player.stats[.agility] ?? 0)
        - Intelligence: \(player.stats[.intelligence] ?? 0)
        - Dexterity: \(player.stats[.dexterity] ?? 0)
        - Luck: \(player.stats[.luck] ?? 0)
        
        ## Boss Generation Instructions
        - Theme inspiration: \(bossTheme)
        """
        
        return prompt
    }
}
