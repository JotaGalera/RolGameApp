//
//  AIGeneratorDataSource.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import Foundation

protocol AIServiceDataSource {
    func generateBoss(prompt: String) async throws -> String
}

class AIServiceDataSourceImplementation: AIServiceDataSource {
    func generateBoss(prompt: String) async throws -> String {
        let apiKey = generateAPIKey()
        let url = URL(string: "https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "max_tokens": 200
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NSError(domain: "AIServiceError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from OpenAI"])
        }
        
        let result = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        return result.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    private func generateAPIKey() -> String {
        guard let path = Bundle.main.path(forResource: "env", ofType: nil),
              let content = try? String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8) else {
            fatalError("No se pudo cargar el archivo .env")
        }
        let lines = content.components(separatedBy: "\n")
        for line in lines {
            if line.starts(with: "OPENAI_API_KEY=") {
                return line.replacingOccurrences(of: "OPENAI_API_KEY=", with: "")
            }
        }
        fatalError("OPENAI_API_KEY no encontrado en .env")
    }
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
    
    struct Choice: Codable {
        let text: String
    }
}
