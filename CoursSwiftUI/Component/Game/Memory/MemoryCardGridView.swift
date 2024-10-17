import SwiftUI

struct MemoryCardGrid: View {
    @ObservedObject var game: MemoryGameService
    
    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: game.cards.count > 12 ? 4 : 3)
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(game.cards) { card in
                MemoryCardView(card: card) {
                    game.flipCard(card)
                }
            }
        }
    }
}
