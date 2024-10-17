import Foundation

func RpsEmojiUtils(for choice: String) -> String {
    switch choice {
    case "Pierre":
        return "🪨"
    case "Feuille":
        return "📄"
    case "Ciseaux":
        return "✂️"
    default:
        return ""
    }
}
