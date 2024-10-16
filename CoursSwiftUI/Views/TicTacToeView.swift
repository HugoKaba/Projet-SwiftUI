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
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                        ForEach(0..<9) { index in
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.purple.opacity(0.5))
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                Text(emoji(for: game.board[index]))
                                    .font(.system(size: 60))
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                game.makeMove(at: index)
                            }
                        }
                    }
                    .padding()
                    
                    Button("Réinitialiser") {
                        game.resetGame()
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                }
                
                Spacer()
            }
        }
    }

    func emoji(for symbol: String) -> String {
        switch symbol {
        case "X":
            return "❌"
        case "O":
            return "⭕"
        default:
            return ""
        }
    }
}

#Preview {
    TicTacToeView(isLoggedIn: .constant(true))
}
