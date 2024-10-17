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
                
                RpsChoicesView(choices: game.choices, onSelect: game.play)
                
                Spacer()

                if let playerChoice = game.playerChoice, let computerChoice = game.computerChoice {
                    RpsChoicesResultView(playerChoice: playerChoice, computerChoice: computerChoice)
                        .padding(.top, 30)
                }
                
                if let resultMessage = game.resultMessage {
                    ResultMessageView(resultMessage: resultMessage)
                        .padding(.top, 20)
                }
                
                ResetButtonView(action: game.resetGame)
                    .padding(.top, 30)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RockPaperScissorsView(isLoggedIn: .constant(true))
}
