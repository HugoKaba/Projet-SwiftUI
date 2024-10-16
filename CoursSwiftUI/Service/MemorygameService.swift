import SwiftUI

class MemoryGameService: ObservableObject {
    @Published var cards: [Card] = []
    @Published var isGameOver = false
    @Published var moves = 0
    private var firstCardIndex: Int?
    private var difficulty: Difficulty = .easy
    
    enum Difficulty {
        case easy, medium, hard
    }

    init() {
        setupGame(with: .easy)
    }

    func setupGame(with difficulty: Difficulty) {
        self.difficulty = difficulty
        moves = 0
        isGameOver = false
        cards = []
        let symbols = ["🍒", "🍋", "🍇", "🍉", "🍀", "🍊", "🍍", "🍏", "🍇", "🍓"]

        let selectedSymbols: [String]
        switch difficulty {
        case .easy:
            selectedSymbols = Array(symbols.prefix(4))
        case .medium:
            selectedSymbols = Array(symbols.prefix(6))
        case .hard:
            selectedSymbols = symbols
        }

        for symbol in selectedSymbols {
            let card1 = Card(symbol: symbol)
            let card2 = Card(symbol: symbol)
            cards.append(contentsOf: [card1, card2])
        }

        cards.shuffle()
    }

    func flipCard(_ card: Card) {
        guard !isGameOver else { return }

        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            if cards[index].isFaceUp {
                return
            }

            moves += 1
            cards[index].isFaceUp.toggle()

            if let firstIndex = firstCardIndex {
                if cards[firstIndex].symbol == cards[index].symbol {
                    firstCardIndex = nil
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.cards[firstIndex].isFaceUp = false
                        self.cards[index].isFaceUp = false
                        self.firstCardIndex = nil
                    }
                }
            } else {
                firstCardIndex = index
            }
        }

        if cards.allSatisfy({ $0.isFaceUp }) {
            isGameOver = true
        }
    }
    
    func restartGame() {
        setupGame(with: difficulty)
    }
}
