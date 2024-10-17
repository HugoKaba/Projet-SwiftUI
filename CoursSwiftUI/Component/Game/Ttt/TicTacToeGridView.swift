import SwiftUI

struct TicTacToeGridView: View {
    let board: [String]
    let onCellTap: (Int) -> Void

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
            ForEach(0..<9) { index in
                ZStack {
                    Rectangle()
                        .foregroundColor(.purple.opacity(0.5))
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    
                    Text(TttEmojiUtils.emoji(for: board[index]))
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    onCellTap(index)
                }
            }
        }
    }
}
