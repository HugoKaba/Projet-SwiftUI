import SwiftUI

struct GameFinishView: View {
    var restartAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Bravo! Vous avez trouvé toutes les paires!")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            
            Button(action: restartAction) {
                Text("Recommencer")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
    }
}
