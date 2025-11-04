//
//  CombatView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 16/9/25.
//

import SwiftUI

struct CombatView: View {
    @StateObject private var viewModel: CombatViewModel
    private let player = Player(name: "Beldrick",
                                classType: .warrior,
                                stats: [.strength: 10,
                                   .agility: 8,
                                   .dexterity: 8,
                                   .health: 15,
                                   .intelligence: 3,
                                   .luck: 1])
    
    init() {
        _viewModel = StateObject(wrappedValue: CombatViewModel(startRunUseCase: StartRunUseCaseFactory.make(),
                                                               checkVictoryConditionUseCase: CheckVictoryConditionUseCaseFactory.make(), getDamageCalculatedUseCase: GetDamageCalculatedUseCaseFactory.make()))
    }
    
    var body: some View {
        VStack {
            switch viewModel.phase?.state {
            case .loading:
                ProgressView("Generating Boss...")
                
            case .inProgress:
                if let boss = viewModel.boss, let player = viewModel.player {
                    VStack {
                        BossView(boss: Binding<BossModel>(
                            get: { boss },
                            set: { _ in }
                        ))
                        
                        SceneCombatView(boss: boss)
                        
                        PlayerCombatActionsView(
                            canTapButtons: Binding<Bool>(
                                get: { viewModel.phase?.turn == .player },
                                set: { _ in }
                            ),
                            player: Binding<PlayerModel>(
                                get: { player },
                                set: { _ in }
                            )
                        ) { action in
                            viewModel.performAction(action)
                        }
                    }
                }
                
            case .victory:
                VStack(spacing: 16) {
                    Text("🏆 ¡Has derrotado al jefe!")
                        .font(.title2)
                    Button("Siguiente combate") {
                        viewModel.nextCombat()
                    }
                    .buttonStyle(RPGButtonStyle(color: .blue))
                }
                
            case .defeat:
                VStack(spacing: 16) {
                    Text("💀 Has sido derrotado")
                        .font(.title2)
                    Button("Empezar nueva partida") {
                        Task {
                            await viewModel.startNewRun()
                        }
                    }
                    .buttonStyle(RPGButtonStyle(color: .red))
                }
                
            case .runVictory:
                VStack(spacing: 16) {
                    Text("🌟 ¡Has completado la run!")
                        .font(.title2)
                    Button("Nueva Run") {
                        Task {
                            await viewModel.startNewRun()
                        }
                    }
                    .buttonStyle(RPGButtonStyle(color: .green))
                }
                
            default:
                EmptyView()
            }
        }
        .task {
            await viewModel.startNewRun()
        }
    }
}

struct SceneCombatView: View {
    var boss: BossModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("👹 \(boss.name)").font(.title).bold()
            Text(boss.description)
            
            Text("Abilities:")
                .font(.headline)
            ForEach(boss.abilities, id: \.self) { ability in
                Text("• \(ability)")
            }
            
            Text("Boss Damage:")
                .font(.headline)
            Text("• \(boss.damage)")
        }
        .padding()
    }
}

#Preview {
    CombatView()
}
