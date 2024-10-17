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
                Text("Score: \(game.score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                SnakeGrid(snake: game.snake, food: game.food)
                    .frame(width: 300, height: 300)
                
                if game.isGameOver {
                    Text("Game Over")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.top, -200)
                }
                
                VStack(spacing: -15) {
                    HStack {
                        Button(action: { game.changeDirection(to: Point(x: 0, y: -1)) }) {
                            Text("↑")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.purple.opacity(0.4))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                                .overlay(Circle()
                                .stroke(Color.purple.opacity(0.5), lineWidth: 4))
                        }
                    }
                    
                    HStack(spacing: 50) {
                        Button(action: { game.changeDirection(to: Point(x: -1, y: 0)) }) {
                            Text("←")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.purple.opacity(0.4))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                                .overlay(Circle()
                                .stroke(Color.purple.opacity(0.5), lineWidth: 4))
                        }
                        Button(action: { game.changeDirection(to: Point(x: 1, y: 0)) }) {
                            Text("→")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.purple.opacity(0.4))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                                .overlay(Circle()
                                .stroke(Color.purple.opacity(0.5), lineWidth: 4))
                        }
                    }
                    
                    HStack {
                        Button(action: { game.changeDirection(to: Point(x: 0, y: 1)) }) {
                            Text("↓")
                                .font(.largeTitle)
                                .frame(width: 60, height: 60)
                                .background(Color.purple.opacity(0.4))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                                .overlay(Circle()
                                .stroke(Color.purple.opacity(0.5), lineWidth: 4))
                        }
                    }
                }
                .padding(.bottom, 10)

                Button(action: {
                    if game.isGameOver {
                        game.restartGame()
                    } else {
                        game.startGame()
                    }
                }) {
                    Text(game.isGameOver ? "Restart" : "Start")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    SnakeGameView(isLoggedIn: .constant(true))
}
