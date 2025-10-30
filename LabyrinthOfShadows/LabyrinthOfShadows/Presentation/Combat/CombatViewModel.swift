//
//  CombatViewModel.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 16/9/25.
//

import Foundation

struct CombatPhase: Equatable {
    let state: CombatViewModel.CombatState
    let turn: Participant
    let victoryCondition: CombatVictoryCondition
}

@MainActor
class CombatViewModel: ObservableObject {
    var run: Run?
    @Published var boss: BossModel?
    var player: PlayerModel?
    @Published var phase: CombatPhase?
    @Published var errorMessage: String?
    
    private let startRunUseCase: StartRunUseCase
    private let checkVictoryConditionUseCase: CheckCombatVictoryConditionUseCase
    private let getDamageCalculatedUseCase: GetDamageCalculatedUseCase
    
    enum CombatState: Equatable {
        case undefined
        case loading
        case inProgress
        case victory
        case defeat
        case runVictory
    }
    
    init(startRunUseCase: StartRunUseCase, checkVictoryConditionUseCase: CheckCombatVictoryConditionUseCase, getDamageCalculatedUseCase: GetDamageCalculatedUseCase) {
        self.startRunUseCase = startRunUseCase
        self.checkVictoryConditionUseCase = checkVictoryConditionUseCase
        self.getDamageCalculatedUseCase = getDamageCalculatedUseCase
    }
    
    func startNewRun() async {
        updatePhase(.loading)
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
        
        let currentTurn: Participant = combat.getCurrentTurn().participant
        let status = checkVictoryCondition(for: player, and: boss)
        updatePhase(.inProgress, turn: currentTurn, condition: status)
        
        // Si empieza el boss, actuará primero
        if currentTurn == .boss {
            bossActionMocked()
        }
    }
    
    private func checkVictoryCondition(for player: PlayerModel?, and boss: BossModel?) -> CombatVictoryCondition {
        guard let player, let boss else { return .ongoing }
        return checkVictoryConditionUseCase(player: player.convertToDomain(), boss: boss.convertToDomain())
    }
    
    private func updatePhase(_ state: CombatState, turn: Participant = .player, condition: CombatVictoryCondition = .ongoing) {
        phase = CombatPhase(state: state, turn: turn, victoryCondition: condition)
    }
    
    func performAction(_ action: Action) {
        guard let player else { return }
        switch action {
        case .attack:
            let damage = calculateDamage(from: player.damage)
            boss = boss?.updateHealth(amount: damage)
            
            checkCombatStatus()
        }
    }
    
    private func calculateDamage(from strength: Int) -> Int {
        return getDamageCalculatedUseCase(for: strength)
    }
    
    private func checkCombatStatus() {
        guard let player, let boss else { return }
        
        let condition = checkVictoryCondition(for: player, and: boss)
        switch condition {
        case .ongoing:
            nextTurn()
        case .playerVictory:
            updatePhase(.victory, turn: .player, condition: condition)
        case .playerDefeat:
            updatePhase(.defeat, turn: .boss, condition: condition)
        }
    }
    
    private func nextTurn() {
        let nextTurnParticipant: Participant = (run?.getCurrentCombat()?.nextTurn())?.participant ?? .player
        updatePhase(.inProgress, turn: nextTurnParticipant, condition: .ongoing)
        
        if nextTurnParticipant == .boss {
            bossActionMocked()
        }
    }
    
    private func bossActionMocked() {
        guard let boss else { return }
        let damage = calculateDamage(from: boss.damage)
        player = player?.updateHealth(amount: damage)
        
        checkCombatStatus()
    }
    
    func nextCombat() {
        guard let newCombat = run?.nextCombat() else {
            finishRun()
            return
        }
        
        startNewCombat(newCombat)
    }
    
    private func finishRun() {
        if run?.isPlayerWinner == true {
            updatePhase(.runVictory, turn: .player, condition: .playerVictory)
        } else {
            updatePhase(.defeat, turn: .boss, condition: .playerDefeat)
        }
    }
    
    private func mockPlayer() -> Player {
        Player(name: "Beldrick", classType: .warrior, stats: [.strength: 10, .agility: 8, .dexterity: 8, .health: 15, .intelligence: 3, .luck: 1])
    }
}
