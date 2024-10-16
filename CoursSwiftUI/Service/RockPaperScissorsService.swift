import Foundation

class RockPaperScissorsService: ObservableObject {
    @Published var playerChoice: String? = nil
    @Published var computerChoice: String? = nil
    @Published var resultMessage: String? = nil

    let choices = ["Pierre", "Feuille", "Ciseaux"]
    
    func play(_ playerSelection: String) {
        playerChoice = playerSelection
        computerChoice = choices.randomElement()
        
        if let player = playerChoice, let computer = computerChoice {
            if player == computer {
                resultMessage = "Égalité!"
            } else if (player == "Pierre" && computer == "Ciseaux") ||
                      (player == "Feuille" && computer == "Pierre") ||
                      (player == "Ciseaux" && computer == "Feuille") {
                resultMessage = "Tu as gagné!"
            } else {
                resultMessage = "Tu as perdu!"
            }
        }
    }

    func resetGame() {
        playerChoice = nil
        computerChoice = nil
        resultMessage = nil
    }
}
