import Foundation

struct Card: Identifiable {
    let id = UUID()
    var symbol: String
    var isFaceUp: Bool = false
}
