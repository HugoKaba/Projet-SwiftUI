import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var game = MemoryGameService()
    @Binding var isLoggedIn: Bool

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
                
                let columns = Array(repeating: GridItem(.flexible()), count: game.cards.count > 12 ? 4 : 3)

                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(game.cards) { card in
                        CardView(card: card) {
                            game.flipCard(card)
                        }
                    }
                }
                .padding()
                
                if game.isGameOver {
                    Text("Bravo! Vous avez trouvé toutes les paires!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    
                    Button(action: {
                        game.restartGame()
                    }) {
                        Text("Recommencer")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                
                HStack {
                    Button(action: {
                        game.setupGame(with: .easy)
                    }) {
                        Text("Facile")
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        game.setupGame(with: .medium)
                    }) {
                        Text("Moyen")
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        game.setupGame(with: .hard)
                    }) {
                        Text("Difficile")
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

struct CardView: View {
    var card: Card
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.opacity(0.7))
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

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView(isLoggedIn: .constant(true))
    }
}
