import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var game = MemoryGameService()
    @Binding var isLoggedIn: Bool
    
    let difficulties: [(title: String, color: Color, level: Difficulty)] = [
        ("Facile", .blue, .easy),
        ("Moyen", .orange, .medium),
        ("Difficile", .red, .hard)
    ]

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Jeu de mémoire 🃏")
            
            VStack {
                Text("Jeu de mémoire")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                Text("Coups: \(game.moves/2)")
                    .font(.headline)
                    .foregroundColor(.white)
                
                MemoryCardGrid(game: game)
                    .padding()
                
                if game.isGameOver {
                    GameFinishView(restartAction: game.restartGame)
                }
                
                DifficultySelectionView(difficulties: difficulties, onSelect: game.setupGame)
                    .padding(.top, 20)
            }
            .padding()
        }
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView(isLoggedIn: .constant(true))
    }
}
