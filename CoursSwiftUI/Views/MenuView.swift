import SwiftUI

struct MenuView: View {
    let appNames = ["Tic-Tac-Toe", "Pierre Feuille Ciseaux","Jackpot","Traffic Light","Jeu de mémoire"]
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()

            CustomNavigationView(isLoggedIn: $isLoggedIn,title: "Menu")

            ScrollView {
                VStack(spacing: 10) {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(appNames, id: \.self) { appName in
                            NavigationLink(destination: destination(for: appName)) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(
                                                colors: [
                                                    Color.blue.opacity(0.7),
                                                    Color.purple.opacity(0.7)
                                                ]),
                                            startPoint: .topLeading, endPoint: .bottomTrailing
                                        ))
                                    .frame(height: 120)
                                    .overlay(
                                        VStack {
                                            Image(appName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.white.opacity(0.8))

                                            Text(appName)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .padding(.top, 5)
                                        }
                                    )
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.70)
        }
    }
    
    @ViewBuilder
    func destination(for appName: String) -> some View {
        switch appName {
        case "Tic-Tac-Toe":
            TicTacToeView(isLoggedIn: $isLoggedIn)
        case "Pierre Feuille Ciseaux":
            RockPaperScissorsView(isLoggedIn: $isLoggedIn)
        case "Jackpot":
            JackpotView(isLoggedIn: $isLoggedIn)
        case "Traffic Light":
            TrafficLightView(isLoggedIn: $isLoggedIn)
        case "Jeu de mémoire":
            MemoryGameView(isLoggedIn: $isLoggedIn)
        default:
            EmptyView()
        }
    }
}

#Preview {
    MenuView(isLoggedIn: .constant(true))
}
