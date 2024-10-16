import SwiftUI

struct TrafficLightView: View {
    @ObservedObject var game = TrafficLightService()
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Feu Rouge 🚦")
            
            VStack {
                Spacer()

                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        ForEach(0..<3) { index in
                            Circle()
                                .foregroundColor(game.lights[index] == .green ? .green : .red)
                                .frame(width: 80, height: 80)
                        }
                    }
                    
                    if !game.message.isEmpty {
                        Text(game.message)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    
                    Button(action: {
                        game.clickButton()
                    }) {
                        Text(game.isGameActive ? "Cliquez maintenant!" : "En attente...")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(game.isGameActive ? Color.green : Color.gray)
                            .cornerRadius(10)
                            .opacity(game.isGameActive ? 1 : 0.5)
                            .disabled(!game.isGameActive)
                    }
                    
                    Button(action: {
                        game.startGame()
                    }) {
                        Text("Démarrer le jeu")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.bottom, 70)
        }
    }
}

#Preview {
    TrafficLightView(isLoggedIn: .constant(true))
}
