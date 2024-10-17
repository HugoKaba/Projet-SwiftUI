import SwiftUI

struct TttEmojiUtils{
    static func emoji(for symbol: String) -> String {
        switch symbol {
        case "X":
            return "❌"
        case "O":
            return "⭕"
        default:
            return ""
        }
    }
}
