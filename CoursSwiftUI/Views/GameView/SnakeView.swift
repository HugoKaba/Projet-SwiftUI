import SwiftUI

struct SnakeGameView: View {
    @ObservedObject var game = SnakeGameService()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Snake 🐍")

            VStack {
                SnakeGrid(gridSize: game.gridSize, isSnakeCell: game.isSnakeCell, isFoodCell: game.isFoodCell)
                    .frame(height: 300)
                    .padding(.top, 60)

                Text("Score: \(game.score)")
                    .font(.title)
                    .padding(.bottom, 5)

                if game.isGameOver {
                    GameOverView(restartAction: {
                        game.restartGame()
                    })
                } else {
                    GameControlsView(changeDirection: game.changeDirection, startGameAction: {
                        game.startGame()
                    })
                }
            }
        }
    }
}

struct SnakeGameView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeGameView(isLoggedIn: .constant(true))
    }
}
