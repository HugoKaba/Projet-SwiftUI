import SwiftUI

class FlappyBirdGameService: ObservableObject {
    @Published var birdY: CGFloat = 200
    @Published var birdX: CGFloat = 100
    @Published var obstacles: [Obstacle] = []
    @Published var score = 0
    @Published var isGameOver = false
    
    let gravity: CGFloat = 5
    let flapHeight: CGFloat = 30
    let obstacleWidth: CGFloat = 60
    let gap: CGFloat = 200
    let obstacleSpeed: CGFloat = 3
    
    var gameTimer: Timer?
    var obstacleTimer: Timer?
    
    init() {
        resetObstacles()
    }
    
    func startGame() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.applyGravity()
            self.moveObstacles()
            self.checkCollisions()
        }
        
        obstacleTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) {
            _ in
            self.addObstacle()
        }
    }
    
    func restartGame() {
        birdY = 200
        score = 0
        isGameOver = false
        resetObstacles()
        startGame()
    }
    
    func flap() {
        birdY -= flapHeight
    }
    
    func applyGravity() {
        birdY += gravity
    }
    
    func moveObstacles() {
        for i in 0..<obstacles.count {
            obstacles[i].x -= obstacleSpeed
        }
        
        obstacles.removeAll { $0.x < -obstacleWidth * 2 }
    }
    
    func addObstacle() {
        let height = CGFloat.random(in: 100...300)
        obstacles.append(Obstacle(x: 500, height: height))
    }
    
    func checkCollisions() {
        if birdY > 400 || birdY < 0 {
            gameOver()
        }
        
        for obstacle in obstacles {
            if birdX + 15 > obstacle.x - obstacleWidth / 2 && birdX - 15 < obstacle.x + obstacleWidth / 2 {
                if birdY < obstacle.height || birdY > obstacle.height + gap {
                    gameOver()
                }
            }
        }
        
        score += 1
    }
    
    func gameOver() {
        isGameOver = true
        gameTimer?.invalidate()
        obstacleTimer?.invalidate()
    }
    
    func resetObstacles() {
        obstacles = []
    }
}

struct Obstacle: Hashable {
    var x: CGFloat
    var height: CGFloat
}
