//
//  playerHUDView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 20/10/25.
//

import SwiftUI

struct PlayerHUDView: View {
    let player: Player

    var mainStat: (String, Int) {
        switch player.classType {
        case .warrior:
            return ("Strength", player.stats[.strength] ?? 0)
        case .thief:
            return ("Dexterity", player.stats[.dexterity] ?? 0)
        case .mage:
            return ("Intelligence", player.stats[.intelligence] ?? 0)
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
            
            HStack {
                ForEach(0..<player.lives, id: \.self) { _ in
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
            
            VStack {
                Text(mainStat.0)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(mainStat.1)")
                    .font(.title2.bold())
            }
            
            
        }
    }
}

#Preview {
    PlayerHUDView(player: Player(name: "Beldrick",
                                 classType: .warrior,
                                 stats: [.strength: 10,
                                    .agility: 8,
                                    .dexterity: 8,
                                    .health: 15,
                                    .intelligence: 3,
                                    .luck: 1]))
}
