import SwiftUI

struct RpsChoicesResultView: View {
    let playerChoice: String
    let computerChoice: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Ton choix : \(RpsEmojiUtils(for: playerChoice))")
            Text("Choix de l'ordinateur : \(RpsEmojiUtils(for: computerChoice))")
        }
        .font(.title2)
        .foregroundColor(.white)
    }
}
