//
//  Boss.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import Foundation

struct Boss: Codable {
    let name: String
    let abilities: [String]
    let stats: [Stats: Int]
    let description: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        abilities = try container.decode([String].self, forKey: .abilities)
        description = try container.decode(String.self, forKey: .description)
        
        let statsDict = try container.decode([String: Int].self, forKey: .stats)
        stats = Dictionary(uniqueKeysWithValues: statsDict.compactMap { key, value in
            guard let stat = Stats(rawValue: key) else { return nil }
            return (stat, value)
        })
    }
}
