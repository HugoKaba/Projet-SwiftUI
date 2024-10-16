import Foundation
import Combine

class TrafficLightService: ObservableObject {
    @Published var lights: [Light] = [.red, .red, .red]
    @Published var message: String = ""
    @Published var reactionTime: Double = 0
    @Published var isGameActive: Bool = false
    private var timer: AnyCancellable?
    private var startTime: Date?

    enum Light {
        case red, green
    }

    func startGame() {
        resetGame()
        
        let randomDelay = Double.random(in: 1...5)
        
        timer = Just(())
            .delay(for: .seconds(randomDelay), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.changeLightsToGreen()
            }
    }

    private func changeLightsToGreen() {
        lights = [.green, .green, .green]
        isGameActive = true
        startTime = Date()
    }
    
    func clickButton() {
        if isGameActive {
            let endTime = Date()
            reactionTime = endTime.timeIntervalSince(startTime ?? Date())
            message = "Bravo! Temps de réaction: \(String(format: "%.2f", reactionTime)) secondes."
            isGameActive = false
        } else {
            message = "Trop tôt! Vous avez perdu!"
            isGameActive = false
            lights = [.red, .red, .red]
            timer?.cancel()
        }
    }

    func resetGame() {
        lights = [.red, .red, .red]
        message = ""
        reactionTime = 0
        isGameActive = false
        timer?.cancel()
    }
}
