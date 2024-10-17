import Foundation
import SwiftUI

class JackpotService: ObservableObject {
    @Published var symbols = ["🍒", "🍋", "🍇", "🍉", "🍀"]
    @Published var reels = [0, 1, 2]
    @Published var credits = 250
    @Published var betAmount = 5
    @Published var message = ""

    func spinReels() {
        message = ""
        _ = reels
        
        let spinDuration = 1.0
        let spinInterval = 0.1
        let totalChanges = Int(spinDuration / spinInterval)

        for i in 0..<totalChanges {
            DispatchQueue.main.asyncAfter(deadline: .now() + spinInterval * Double(i)) {
                self.reels = self.reels.map { _ in Int.random(in: 0..<self.symbols.count) }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + spinDuration) {
            self.credits -= self.betAmount

            if self.reels[0] == self.reels[1] && self.reels[1] == self.reels[2] {
                let multiplier = self.getMultiplier(for: self.reels[0])
                let winnings = self.betAmount * multiplier
                self.credits += winnings
                self.message = "Bravo! Gagné \(winnings) crédits avec un multiplicateur x\(multiplier)!"
            } else {
                self.message = "Dommage! Réessayez!"
            }
        }
    }

    func increaseBet(by amount: Int) {
        if betAmount + amount <= credits {
            betAmount += amount
            message = ""
        } else {
            message = "Vous ne pouvez pas miser plus de crédits que vous n'en avez!"
        }
    }

    func decreaseBet() {
        if betAmount > credits{
            betAmount = credits
            message = ""
        }else if betAmount > 5 {
            betAmount -= 5
            message = ""
        } else {
            message = "La mise ne peut pas être inférieure à 5 crédits!"
        }
    }

    func getMultiplier(for symbol: Int) -> Int {
        switch symbols[symbol] {
        case "🍒": return 5
        case "🍇": return 10
        case "🍉": return 3
        case "🍋": return 2
        case "🍀": return 20
        default: return 1
        }
    }

    func resetGame() {
        credits = 250
        betAmount = 5
        reels = [0, 1, 2]
        message = ""
    }
}
