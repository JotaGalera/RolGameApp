//
//  BossView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 20/10/25.
//

import SwiftUI

struct BossView: View {
    @Binding var boss: BossModel
    var currentHealth: Int {
        boss.currentHealth
    }
    var maxHealth: Int {
        boss.maxHealth
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("👹 \(boss.name)").font(.title).bold()
            
            Text(boss.name)
                .font(.headline)
                .foregroundColor(.white)
            
            HealthBarView(currentHealth: Binding<Int>(get: { currentHealth }, set: { _ in }),
                          maxHealth: Binding<Int>(get: { maxHealth }, set: { _ in }))
            
            
        }
        .padding(.horizontal)
    }
}



#Preview {
    BossView(boss: .constant(BossModel(name: "Dragon",
                                       abilities: ["Dragon flames", "Breathe fire", "Tail swipe"],
                                       description: "A fearsome dragon with fiery breath and razor-sharp claws.",
                                       maxHealth: 150,
                                       damage: 12)))
}
