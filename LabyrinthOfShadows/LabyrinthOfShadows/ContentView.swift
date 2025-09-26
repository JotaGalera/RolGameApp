//
//  ContentView.swift
//  LabyrinthOfShadows
//
//  Created by Javier Galera Garrido on 27/8/25.
//

import FoundationModels
import SwiftUI

struct ContentView: View {
    var body: some View {
        GenerativeView()
    }
}
    
struct GenerativeView: View {
    private var model = SystemLanguageModel.default
    
    var body: some View {
        switch model.availability {
        case .available:
            CombatView()
        case .unavailable(let reason):
            Text(unavailableReasonDescription(reason))
        }
    }
}

private func unavailableReasonDescription(_ reason: SystemLanguageModel.Availability.UnavailableReason) -> String {
    switch reason {
    case .deviceNotEligible:
        return "This device is not compatible with Apple Intelligence."
    case .appleIntelligenceNotEnabled:
        return "Please turn on Apple Intelligence."
    case .modelNotReady:
        return "The model is currently downloading."
    @unknown default:
        return "An unknown error occurred."
    }
}

#Preview {
    ContentView()
}
