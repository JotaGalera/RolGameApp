//
//  playerHUDView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 20/10/25.
//

import SwiftUI

struct PlayerHUDView: View {
    @Binding var player: PlayerModel
    @State private var shakeTrigger: Bool = false
    
    var currentHealth: Int {
        player.currentHealth
    }
    
    var maxHealth: Int {
        player.maxHealth
    }
    
    var mainStat: (String, Int) {
        switch player.classType {
        case .warrior:
            return ("Strength", player.damage)
        case .thief:
            return ("Dexterity", player.damage)
        case .mage:
            return ("Intelligence", player.damage)
        }
    }
    
    var imageName: String {
        switch player.classType {
        case .warrior:
            return "warrior_hud"
        case .thief:
            return "thief_hud"
        case .mage:
            return "mage_hud"
        }
    }
    
    var body: some View {
        HStack() {
            
            Image(imageName)
                .resizable()
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            VStack {
                HStack {
                    ForEach(0..<player.maxLives, id: \.self) { index in
                        Image(systemName: index < player.currentLives ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.title3)
                            .scaleEffect(shakeTrigger && index == player.currentLives ? 1.3 : 1.0)
                            .animation(.spring(response: 0.2, dampingFraction: 0.3), value: shakeTrigger)
                    }
                }
                .modifier(ShakeEffect(animatableData: CGFloat(shakeTrigger ? 1 : 0)))
                
                HealthBarView(currentHealth: Binding<Int>(get: { currentHealth }, set: { _ in }),
                              maxHealth: Binding<Int>(get: { maxHealth }, set: { _ in }))
            }
            
            Spacer()
            
            VStack {
                Text(mainStat.0)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(mainStat.1)")
                    .font(.title2.bold())
            }
            .onChange(of: player.currentLives) { _, _ in
                shakeTrigger.toggle()
            }
            
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 6
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}

#Preview {
    PlayerHUDView(player: .constant(PlayerModel(name: "Beldrick",
                                                classType: .warrior,
                                                maxHealth: 100,
                                                maxLives: 3,
                                                damage: 5)))
}
