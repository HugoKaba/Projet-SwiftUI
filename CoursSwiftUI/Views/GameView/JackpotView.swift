import SwiftUI

struct JackpotView: View {
    @ObservedObject var game = JackpotService()
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Jackpot 🍀")
            
            VStack {
                VStack {
                    JackpotCreditsView(credits: game.credits)
                    
                    JackpotReelsView(reels: game.reels, symbols: game.symbols)
                    
                    if !game.message.isEmpty {
                        Text(game.message)
                            .font(.title)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    SpinButtonView(
                        betAmount: game.betAmount,
                        credits: game.credits,
                        spinAction: { game.spinReels() },
                        errorMessage: { game.message = "Pas assez de crédits!" }
                    )

                    Text("Choisir une mise:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    BetAmountButtonsView(increaseBet: game.increaseBet)
                        .padding(.top, 10)

                    DecreaseBetButtonView(decreaseBet: game.decreaseBet)

                    ResetButtonView(action: game.resetGame)
                        .padding(.top, 20)
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.bottom, 70)
        }
    }
}

#Preview {
    JackpotView(isLoggedIn: .constant(true))
}
