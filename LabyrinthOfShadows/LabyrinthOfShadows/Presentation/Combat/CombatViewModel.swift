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
    @Published var viewState: CombatState = .loading
    @Published var errorMessage: String?
    @Published var isPlayerTurn: Bool?
    @Published var combatStatus: CombatVictoryCondition?
    
    private let startRunUseCase: StartRunUseCase
    private let checkVictoryConditionUseCase: CheckCombatVictoryConditionUseCase
    
    enum CombatState: Equatable {
        case loading
        case inProgress
        case victory
        case defeat
        case runVictory
        case newGame
    }
    
    init(startRunUseCase: StartRunUseCase, checkVictoryConditionUseCase: CheckCombatVictoryConditionUseCase) {
        self.startRunUseCase = startRunUseCase
        self.checkVictoryConditionUseCase = checkVictoryConditionUseCase
    }
    
    func startNewRun() async {
        viewState = .loading
        errorMessage = nil
        do {
            run = try await startRunUseCase(for: mockPlayer())
            
            guard let combat = run?.getCurrentCombat() else { return }
            
            startNewCombat(combat)

        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func startNewCombat(_ combat: Combat) {
        boss = combat.boss.convertToPresentationModel()
        player = combat.player.convertToPresentationModel()
        isPlayerTurn = combat.getCurrentTurn().participant == .player
        
        viewState = .inProgress
        updateCombatStatus()
        
        //TODO: Trigger just in case Boss has more agility than the player
        if isPlayerTurn == false {
            bossActionMocked()
        }
    }
    
    private func updateCombatStatus() {
        guard let player, let boss else { return }
        
        combatStatus = checkVictoryConditionUseCase(player: player.convertToDomain(), boss: boss.convertToDomain())
    }
    
    func performAction(_ action: Action) {
        switch action {
        case .attack:
            guard let player else { return }
            let damage = calculateDamage(from: player.damage)
            boss = boss?.updateHealth(amount: damage)
            
            checkCombatStatus()
        }
    }
    
    private func calculateDamage(from strength: Int) -> Int {
        return 1 + (strength / 5)
    }

    private func checkCombatStatus() {
        updateCombatStatus()
        
        switch combatStatus {
        case .ongoing:
            viewState = .inProgress
            nextTurn()
        case .playerVictory:
            viewState = .victory
        case .playerDefeat:
            viewState = .defeat
        case nil:
            return
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
        
        checkCombatStatus()
    }
    
    func nextCombat() {
        guard let newCombat = run?.nextCombat() else {
            finishGame()
            return
        }
        
        startNewCombat(newCombat)
    }
    
    private func finishGame() {
        if run?.isPlayerWinner == true {
            viewState = .runVictory
        } else {
            viewState = .defeat
        }
    }
    
        
    private func mockPlayer() -> Player {
        Player(name: "Beldrick", classType: .warrior, stats: [.strength: 10, .agility: 8, .dexterity: 8, .health: 15, .intelligence: 3, .luck: 1])
    }
}
