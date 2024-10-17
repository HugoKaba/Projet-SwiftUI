import SwiftUI

struct FlappyBirdGameView: View {
    @ObservedObject var game = FlappyBirdGameService()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Flappy Bird 🐥")
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        BirdView(birdX: game.birdX, birdY: game.birdY)
                        
                        ForEach(game.obstacles, id: \.self) { obstacle in
                            ObstacleView(obstacle: obstacle, obstacleWidth: game.obstacleWidth, gap: game.gap)
                        }
                    }
                }
                .frame(height: 400)
                
                Text("Score: \(game.score)")
                    .font(.title)
                    .padding(.top, 20)
                
                if game.isGameOver {
                    Button("Restart") {
                        game.restartGame()
                    }
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Button("Flap") {
                        game.flap()
                    }
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .onAppear {
            game.startGame()
        }
    }
}

struct FlappyBirdGameView_Previews: PreviewProvider {
    static var previews: some View {
        FlappyBirdGameView(isLoggedIn: .constant(true))
    }
}
