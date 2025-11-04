//
//  HealthBarView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 4/11/25.
//

import SwiftUI

struct HealthBarView: View {
    @Binding var currentHealth: Int
    @Binding var maxHealth: Int
    
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
}

#Preview {
    HealthBarView(currentHealth: .constant(50), maxHealth: .constant(100))
}
