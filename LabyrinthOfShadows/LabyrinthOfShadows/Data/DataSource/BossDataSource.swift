//
//  AIGeneratorDataSource.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//
import Foundation
import FoundationModels

protocol BossDataSource {
    func generateBoss(prompt: String) async throws -> Boss
}

struct BossDataSourceImplementation: BossDataSource {
    func generateBoss(prompt: String) async throws -> Boss {
        let session = LanguageModelSession(model: .default, instructions: generateIntrunctions())
        
        let content = try await session.respond(to: prompt).content
        let cleanedResponse = cleanJSONResponse(content)
        
        print("RAW JSON:\n\(cleanedResponse)")
        
        guard let jsonData = cleanedResponse.data(using: .utf8) else {
            throw NSError(domain: "AIServiceError", code: 3, userInfo: [NSLocalizedDescriptionKey: "No se pudo convertir a Data"])
        }
        
        do {
            let boss = try JSONDecoder().decode(Boss.self, from: jsonData)
            return boss
        } catch {
            throw NSError(
                domain: "AIServiceError",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Parsing error: \(error.localizedDescription)\nResponse: \(jsonData)"]
            )
        }
    }
    
    func generateIntrunctions() -> String {
        let instructions: String = """
            You are a final boss generator for a turn-based combat video game.
            
            Game rules:
            - The combat is lost by whoever reaches 0 health.
            - Turns are determined by Agility.
            - Every 10 points of Agility difference grant an extra turn.
            - Damage is based on Strength: every 5 points of Strength deal 1 additional point of damage.
            - The boss should be challenging but beatable according to the player's stats.
            - **IMPORTANT:** Return **only** a JSON object. Do not include explanations, markdown, commentary, or any extra text. The JSON must match exactly this format:
            {
            "name": "string",
            "abilities": ["string", "string", "string"],
            "stats": {
                "health": int,
                "strength": int,
                "agility": int,
                "intelligence": int,
                "dexterity": int,
                "luck": int
            },
            "description": "string"
            }
            
            - **Boss stats must strictly follow these limits relative to the player**:
              - Health: boss health ≥ player health and ≤ player health * 1.3
              - Strength: boss strength ≤ player strength + 3
              - Agility: boss agility ≤ player agility + 2
              - Dexterity: boss dexterity ≤ player dexterity + 2
              - Intelligence: boss intelligence ≤ max(player intelligence, 5)
              - Luck: boss luck ≤ max(player luck, 3)

            - Balance the boss using expected combat:
              - Damage per turn should be comparable to the player's expected damage.
              - Agility differences determine extra turns; adjust so the player can win with strategic play.

            - Boss abilities should be thematically appropriate and balanced.
            - Description should be 1-2 sentences, flavorful, but do **not** include combat analysis or calculations.
            """
        return instructions
    }
    
    func cleanJSONResponse(_ text: String) -> String {
        var cleaned = text
        
        cleaned = cleaned.replacingOccurrences(of: "```json", with: "")
        cleaned = cleaned.replacingOccurrences(of: "```", with: "")
        
        cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return cleaned
    }
}
