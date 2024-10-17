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
                    TrafficLightIndicator(lights: game.lights)

                    GameMessageView(message: game.message)

                    ActionButton(
                       title: game.isGameActive ? "Cliquez maintenant!" : "En attente...",
                       action: {
                           game.clickButton()
                       },
                       isActive: game.isGameActive,
                       buttonColor: AnyView(game.isGameActive ? Color.green : Color.gray)
                   )

                    ActionButton(
                        title: "Démarrer le jeu",
                        action: {
                            game.startGame()
                        },
                        isActive: true,
                        buttonColor: AnyView(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    )
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
