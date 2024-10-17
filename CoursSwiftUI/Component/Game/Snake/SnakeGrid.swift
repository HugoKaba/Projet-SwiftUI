import SwiftUI

struct SnakeGrid: View {
    var gridSize: Int
    var isSnakeCell: (Int, Int) -> Bool
    var isFoodCell: (Int, Int) -> Bool

    var body: some View {
        GeometryReader { geometry in
            let gridDimension = min(geometry.size.width, geometry.size.height)
            let cellSize = gridDimension / CGFloat(self.gridSize)
            HStack{
                Spacer()
                VStack {
                    ForEach(0..<gridSize, id: \.self) { row in
                        HStack {
                            ForEach(0..<gridSize, id: \.self) { col in
                                Rectangle()
                                    .fill(isSnakeCell(row, col) ? Color.green : (isFoodCell(row, col) ? Color.red : Color.clear))
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
                .frame(width: gridDimension, height: gridDimension)
                .border(Color.black, width: 2)
                Spacer()
            }
        }
    }
}
