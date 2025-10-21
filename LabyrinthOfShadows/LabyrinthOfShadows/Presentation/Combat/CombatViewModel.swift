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
    @Published var boss: BossModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let startRunUseCase: StartRunUseCase
    
    init(startRunUseCase: StartRunUseCase) {
        self.startRunUseCase = startRunUseCase
    }
    
    func startNewRun() async {
        isLoading = true
        errorMessage = nil
        do {
            run = try await startRunUseCase(for: mockPlayer())
            boss = run?.getCurrentCombat()?.boss.convertToPresentationModel()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func performAction(_ action: Action) {
        switch action {
        case .attack:
            guard let player = run?.getCurrentCombat()?.player else { return }
            let damage = calculateDamage(from: player)
            boss = boss?.updateHealth(amount: damage)
        }
    }
    
    private func calculateDamage(from player: Player) -> Int {
        let strength = player.stats[.strength] ?? 0
        return 1 + (strength / 5)
    }
    
    private func mockPlayer() -> Player {
        Player(name: "Beldrick", classType: .warrior, stats: [.strength: 10, .agility: 8, .dexterity: 8, .health: 15, .intelligence: 3, .luck: 1])
    }
}
