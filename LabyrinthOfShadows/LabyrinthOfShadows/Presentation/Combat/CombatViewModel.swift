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
    var player: PlayerModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isPlayerTurn: Bool?
    
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
            player = run?.getCurrentCombat()?.player.convertToPresentationModel()
            isPlayerTurn = run?.getCurrentCombat()?.getCurrentTurn().participant == .player
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func performAction(_ action: Action) {
        switch action {
        case .attack:
            guard let player else { return }
            let damage = calculateDamage(from: player.damage)
            boss = boss?.updateHealth(amount: damage)
            
            nextTurn()
        }
    }
    
    private func nextTurn() {
        let newTurn = run?.getCurrentCombat()?.nextTurn()
        isPlayerTurn = newTurn?.participant == .player
        
        if isPlayerTurn == false {
            bossActionMocked()
        }
    }
    
    private func bossActionMocked() { // TODO: Make a boss logic 
        guard let boss else { return }
        let damage = calculateDamage(from: boss.damage)
        player = player?.updateHealth(amount: damage)
        
        nextTurn()
    }
    
    private func calculateDamage(from strength: Int) -> Int {
        return 1 + (strength / 5)
    }
    
    private func mockPlayer() -> Player {
        Player(name: "Beldrick", classType: .warrior, stats: [.strength: 10, .agility: 8, .dexterity: 8, .health: 15, .intelligence: 3, .luck: 1])
    }
}
