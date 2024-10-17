import SwiftUI
import Combine

struct Point: Equatable {
    var x: Int
    var y: Int
}

class SnakeGameService: ObservableObject {
    @Published var snake: [Point] = [Point(x: 5, y: 5)]
    @Published var food: Point = Point(x: 3, y: 3)
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    var direction: Point = Point(x: 0, y: 1)
    
    private var timer: AnyCancellable?
    
    func startGame() {
        self.score = 0
        self.snake = [Point(x: 5, y: 5)]
        self.food = generateFood()
        self.isGameOver = false
        
        timer = Timer.publish(every: 0.2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.moveSnake()
            }
    }
    
    func restartGame() {
        timer?.cancel()
        startGame()
    }
    
    func generateFood() -> Point {
        let x = Int.random(in: 0..<10)
        let y = Int.random(in: 0..<10)
        return Point(x: x, y: y)
    }
    
    func moveSnake() {
        let newHead = Point(x: snake[0].x + direction.x, y: snake[0].y + direction.y)
        
        if newHead.x < 0 || newHead.x >= 10 || newHead.y < 0 || newHead.y >= 10 || snake.contains(newHead) {
            isGameOver = true
            timer?.cancel()
            return
        }
        
        snake.insert(newHead, at: 0)
        
        if newHead.x == food.x && newHead.y == food.y {
            score += 1
            food = generateFood()
        } else {
            snake.removeLast()
        }
    }
    
    func changeDirection(to newDirection: Point) {
        if (newDirection.x * -1 != direction.x) || (newDirection.y * -1 != direction.y) {
            direction = newDirection
        }
    }
}
