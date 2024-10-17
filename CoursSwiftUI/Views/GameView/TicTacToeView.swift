import SwiftUI

struct TicTacToeView: View {
    @ObservedObject var game = TicTacToeService()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Tic-Tac-Toe")
            
            VStack {
                Spacer()
                
                VStack {
                    Text(game.winner ?? "Tour de \(game.currentPlayer)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()

                    TicTacToeGridView(board: game.board) { index in
                        game.makeMove(at: index)
                    }
                    .padding()

                    ResetButtonView(action: game.resetGame)
                        .padding(.top, 30)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    TicTacToeView(isLoggedIn: .constant(true))
}
