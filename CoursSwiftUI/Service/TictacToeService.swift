import Foundation

class TicTacToeService: ObservableObject {
    @Published var board = Array(repeating: "", count: 9)
    @Published var currentPlayer = "X"
    @Published var winner: String? = nil

    func makeMove(at index: Int) {
        if board[index] == "" && winner == nil {
            board[index] = currentPlayer
            if checkWin(for: currentPlayer) {
                winner = "\(currentPlayer) a gagné!"
            } else if board.allSatisfy({ $0 != "" }) {
                winner = "Égalité!"
            } else {
                currentPlayer = (currentPlayer == "X") ? "O" : "X"
            }
        }
    }

    func checkWin(for player: String) -> Bool {
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Columns
            [0, 4, 8], [2, 4, 6]              // Diagonals
        ]
        return winPatterns.contains { pattern in
            pattern.allSatisfy { board[$0] == player }
        }
    }

    func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        winner = nil
    }
}
