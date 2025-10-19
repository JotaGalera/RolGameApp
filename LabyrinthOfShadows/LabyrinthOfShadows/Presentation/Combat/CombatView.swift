//
//  CombatView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 16/9/25.
//

import SwiftUI

struct CombatView: View {
    @StateObject private var viewModel: CombatViewModel
    
    init() {
        let dataSource = BossDataSourceImplementation()
        let repository = BossRepositoryImplementation(generatorDataSource: dataSource)
        let useCase = StartRunUseCaseImplementation(bossGenerator: repository)
        _viewModel = StateObject(wrappedValue: CombatViewModel(startRunUseCase: useCase))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Generating Boss...")
            } else if let boss = viewModel.boss {
                VStack(alignment: .leading, spacing: 12) {
                    Text("👹 \(boss.name)").font(.title).bold()
                    Text(boss.description)
                    
                    Text("Abilities:")
                        .font(.headline)
                    ForEach(boss.abilities, id: \.self) { ability in
                        Text("• \(ability)")
                    }
                    
                    Text("Stats:")
                        .font(.headline)
                    ForEach(boss.stats.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { stat in
                        Text("\(stat.rawValue.capitalized): \(boss.stats[stat] ?? 0)")
                    }
                }
                .padding()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red)
            }
        }
        .task {
            await viewModel.loadBoss()
        }
    }
}

#Preview {
    CombatView()
}
