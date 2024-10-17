import SwiftUI

struct SnakeGrid: View {
    var snake: [Point]
    var food: Point
    
    var body: some View {
        let gridSize = 10
        let cellSize: CGFloat = 30
        
        VStack(spacing: 0) {
            ForEach(0..<gridSize, id: \.self) { y in
                HStack(spacing: 0) {
                    ForEach(0..<gridSize, id: \.self) { x in
                        Rectangle()
                            .fill(self.colorForCell(x: x, y: y))
                            .frame(width: cellSize, height: cellSize)
                    }
                }
            }
        }
    }
    
    func colorForCell(x: Int, y: Int) -> Color {
        if snake.contains(Point(x: x, y: y)) {
            return .green
        } else if food.x == x && food.y == y {
            return .red
        } else {
            return .black
        }
    }
}
