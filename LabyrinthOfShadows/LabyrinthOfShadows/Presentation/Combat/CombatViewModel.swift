//
//  CombatViewModel.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 16/9/25.
//

import Foundation

@MainActor
class CombatViewModel: ObservableObject {
    @Published var boss: Boss?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let generateBossUseCase: GenerateBossUseCase
    
    init(generateBossUseCase: GenerateBossUseCase) {
        self.generateBossUseCase = generateBossUseCase
    }
    
    func loadBoss() async {
        isLoading = true
        errorMessage = nil
        do {
            let result = try await generateBossUseCase()
            boss = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
