//
//  BossView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 20/10/25.
//

import SwiftUI

struct BossView: View {
    let boss: BossModel
    var currentHealth: Int {
        boss.currentHealth
    }
    var maxHealth: Int {
        boss.maxHealth
    }
    
    private var healthPercentage: Double {
            Double(currentHealth) / Double(maxHealth)
        }

        private var barColor: Color {
            switch healthPercentage {
            case 0.6...1.0: return .green
            case 0.3..<0.6: return .yellow
            default: return .red
            }
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("👹 \(boss.name)").font(.title).bold()
            
            Text(boss.name)
                .font(.headline)
                .foregroundColor(.white)
            
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 18)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(barColor)
                        .frame(width: max(0, min(1, healthPercentage)) * proxy.size.width,
                               height: 18)
                        .animation(.easeInOut(duration: 0.3), value: currentHealth)
                }
            }
            .frame(height: 18)
            
            Text("\(currentHealth) / \(maxHealth)")
                .font(.caption)
                .foregroundColor(.black.opacity(0.7))
        }
        .padding(.horizontal)
    }
}

#Preview {
    BossView(boss: BossModel(name: "Dragon",
                             abilities: ["Dragon flames", "Breathe fire", "Tail swipe"],
                             description: "A fearsome dragon with fiery breath and razor-sharp claws.",
                             maxHealth: 150,
                             damage: 12))
}
