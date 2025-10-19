//
//  UserCombatInterfazeView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 19/10/25.
//

import SwiftUI

struct UserCombatView: View {
    @Namespace private var animationNamespace
    @State private var showingAbilities = false
    @State private var abilityCooldowns: [String: Int] = [
        "Slash": 0,
        "Power Strike": 0,
        "Shield Bash": 0,
        "Fury": 0
    ]

    let abilities: [(name: String, damage: Int, cooldown: Int)] = [
        ("Slash", 3, 2),
        ("Power Strike", 5, 3),
        ("Shield Bash", 2, 1),
        ("Fury", 6, 4)
    ]

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        showingAbilities = false
                    }
                }

            VStack {
                Spacer()
                
                if showingAbilities {
                    let columns = [GridItem(.flexible()), GridItem(.flexible())]

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(abilities, id: \.name) { ability in
                            Button(action: { useAbility(ability) }) {
                                VStack {
                                    Text(ability.name).bold()
                                    Text("DMG: \(ability.damage)")
                                    Text("CD: \(abilityCooldowns[ability.name] ?? 0)")
                                }
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 80)
                                .background(abilityCooldowns[ability.name] ?? 0 > 0 ? Color.gray : Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .matchedGeometryEffect(id: ability.name, in: animationNamespace)
                            }
                            .disabled(abilityCooldowns[ability.name] ?? 0 > 0)
                        }
                    }
                    .padding()
                    .transition(.scale.combined(with: .opacity))
                } else {
                    // Botones principales
                    HStack(spacing: 16) {
                        Button("Attack") { print("Attack pressed") }
                            .buttonStyle(RPGButtonStyle(color: .red))

                        Button("Abilities") {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                showingAbilities = true
                            }
                        }
                        .buttonStyle(RPGButtonStyle(color: .blue))
                        .matchedGeometryEffect(id: "AbilitiesButton", in: animationNamespace)

                        Button("Run") { print("Run pressed") }
                            .buttonStyle(RPGButtonStyle(color: .gray))
                    }
                    .padding()
                }
            }
            .padding()
        }
    }

    private func useAbility(_ ability: (name: String, damage: Int, cooldown: Int)) {
        print("Using \(ability.name) for \(ability.damage) damage")
        abilityCooldowns[ability.name] = ability.cooldown

        for key in abilityCooldowns.keys {
            if abilityCooldowns[key]! > 0 {
                abilityCooldowns[key]! -= 1
            }
        }
    }
}

struct RPGButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 100, height: 80)
            .background(
                ZStack {
                    LinearGradient(colors: [color.opacity(0.8), color],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .cornerRadius(12)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        .blendMode(.overlay)
                }
            )
            .foregroundColor(.white)
            .shadow(color: .black.opacity(configuration.isPressed ? 0.1 : 0.4),
                    radius: configuration.isPressed ? 2 : 6,
                    x: 2, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    UserCombatView()
}
