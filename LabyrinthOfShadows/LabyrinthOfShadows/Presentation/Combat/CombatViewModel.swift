//
//  CombatViewModel.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 16/9/25.
//

import Foundation

@MainActor
class CombatViewModel: ObservableObject {
    var run: Run?
    @Published var boss: Boss?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let startRunUseCase: StartRunUseCase
    
    init(startRunUseCase: StartRunUseCase) {
        self.startRunUseCase = startRunUseCase
    }
    
    func loadBoss() async {
        isLoading = true
        errorMessage = nil
        do {
            run = try await startRunUseCase(for: mockPlayer())
            boss = run?.combats.first?.boss
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    private func mockPlayer() -> Player {
        Player(name: "Beldrick", classType: .warrior, stats: [.strength: 10, .agility: 8, .dexterity: 8, .health: 15, .intelligence: 3, .luck: 1])
    }
}
