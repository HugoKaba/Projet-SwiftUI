import SwiftUI

struct ResetButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button("Réinitialiser", action: action)
            .font(.title2)
            .foregroundColor(.white)
    }
}
