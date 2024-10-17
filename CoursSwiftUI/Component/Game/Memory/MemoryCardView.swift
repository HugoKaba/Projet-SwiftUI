import SwiftUI

struct MemoryCardView: View {
    var card: Card
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.purple.opacity(0.7))
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            if card.isFaceUp {
                Text(card.symbol)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            action()
        }
    }
}
