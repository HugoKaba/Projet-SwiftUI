import SwiftUI

struct RockPaperScissorsView: View {
    @ObservedObject var game = RockPaperScissorsService()
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Pierre Feuille Ciseaux")
            VStack {
                Spacer()
                VStack {
                    HStack(spacing: 20) {
                        ForEach(game.choices, id: \.self) { choice in
                            Button(action: {
                                game.play(choice)
                            }) {
                                Text(emoji(for: choice))
                                    .font(.system(size: 80))
                                    .padding()
                                    .background(Color.purple.opacity(0.7))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                        }
                    }

                    if let playerChoice = game.playerChoice, let computerChoice = game.computerChoice {
                        VStack(spacing: 20) {
                            Text("Ton choix : \(emoji(for: playerChoice))")
                            Text("Choix de l'ordinateur : \(emoji(for: computerChoice))")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    }

                    if let resultMessage = game.resultMessage {
                        Text(resultMessage)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }

                    Button("Réinitialiser") {
                        game.resetGame()
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func emoji(for choice: String) -> String {
        switch choice {
        case "Pierre":
            return "🪨"
        case "Feuille":
            return "📄"
        case "Ciseaux":
            return "✂️"
        default:
            return ""
        }
    }
}

#Preview {
    RockPaperScissorsView(isLoggedIn: .constant(true))
}
