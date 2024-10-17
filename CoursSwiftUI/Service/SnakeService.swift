import SwiftUI

class SnakeGameService: ObservableObject {
    @Published var gridSize = 10
    @Published var snake: [(Int, Int)] = [(5, 5)]
    @Published var direction: Direction = .right
    @Published var food: (Int, Int) = (3, 3)
    @Published var score = 0
    @Published var isGameOver = false
    var timer: Timer?
    
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            self.moveSnake()
        }
    }
    
    func restartGame() {
        snake = [(5, 5)]
        direction = .right
        food = generateNewFood()
        score = 0
        isGameOver = false
        startGame()
    }
    
    func changeDirection(to newDirection: Direction) {
        if (direction == .up && newDirection != .down) ||
            (direction == .down && newDirection != .up) ||
            (direction == .left && newDirection != .right) ||
            (direction == .right && newDirection != .left) {
            direction = newDirection
        }
    }
    
    func moveSnake() {
        var newHead = snake.first!
        
        switch direction {
        case .up:
            newHead.0 -= 1
        case .down:
            newHead.0 += 1
        case .left:
            newHead.1 -= 1
        case .right:
            newHead.1 += 1
        }
        
        if newHead.0 < 0 || newHead.0 >= gridSize || newHead.1 < 0 || newHead.1 >= gridSize || snake.contains(where: { $0 == newHead }) {
            isGameOver = true
            timer?.invalidate()
            return
        }
        
        snake.insert(newHead, at: 0)
        
        if newHead == food {
            score += 1
            food = generateNewFood()
        } else {
            snake.removeLast()
        }
    }
    
    func isSnakeCell(row: Int, col: Int) -> Bool {
        return snake.contains(where: { $0.0 == row && $0.1 == col })
    }
    
    func isFoodCell(row: Int, col: Int) -> Bool {
        return food.0 == row && food.1 == col
    }
    
    private func generateNewFood() -> (Int, Int) {
        var newFood: (Int, Int)
        repeat {
            newFood = (Int.random(in: 0..<gridSize), Int.random(in: 0..<gridSize))
        } while snake.contains(where: { $0 == newFood })
        return newFood
    }
}

enum Direction {
    case up, down, left, right
}
