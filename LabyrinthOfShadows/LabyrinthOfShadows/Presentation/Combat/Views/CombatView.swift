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
                                                               checkVictoryConditionUseCase: CheckVictoryConditionUseCaseFactory.make()))
    }
    
    var body: some View {
        VStack {
            if viewModel.viewState == .loading {
                ProgressView("Generating Boss...")
            } else if let boss = viewModel.boss, viewModel.viewState == .inProgress {
                VStack {
                    BossView(boss: boss)
                    
                    SceneCombatView(boss: boss)
                    
                    PlayerCombatActionsView(
                        canTapButtons: Binding<Bool>(
                            get: { viewModel.isPlayerTurn ?? false },
                            set: { _ in }
                        )
                    ) { action in
                        viewModel.performAction(action)
                    }
                }
            } else if viewModel.viewState == .victory {
                Text(" Player is the Winner !!!")
                
                Button("Next Combat") {
                    viewModel.nextCombat()
                }
                .buttonStyle(RPGButtonStyle(color: .blue))
            } else if viewModel.viewState == .defeat {
                Text(" Player die !!!")
                
                Button("Next Combat") {
                    Task {
                        await viewModel.startNewRun()
                    }
                }
                .buttonStyle(RPGButtonStyle(color: .red))
            } else if viewModel.viewState == .runVictory {
                Text(" Your pass the RUN !!!!")
                
                Button("New Run") {
                    Task {
                        await viewModel.startNewRun()
                    }
                }
                .buttonStyle(RPGButtonStyle(color: .red))
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red)
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
