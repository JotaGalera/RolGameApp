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
        let instructions = """
                Eres un generador de jefes finales para videojuegos.
                Devuelve SIEMPRE un objeto JSON válido con este formato:
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
                """
        let session = LanguageModelSession(model: .default, instructions: instructions)
        
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
    
    private func cleanJSONResponse(_ text: String) -> String {
        var cleaned = text
        
        cleaned = cleaned.replacingOccurrences(of: "```json", with: "")
        cleaned = cleaned.replacingOccurrences(of: "```", with: "")
        
        cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return cleaned
    }
}
