import SwiftUI

struct MenuView: View {
    @Binding var isLoggedIn: Bool

    var apps: [AppInfo] = {
        [
            AppInfo(name: "Tic-Tac-Toe", imageName: "TicTacToe", view: AnyView(TicTacToeView(isLoggedIn: .constant(true)))),
            AppInfo(name: "Pierre Feuille Ciseaux", imageName: "RockPaperScissors", view: AnyView(RockPaperScissorsView(isLoggedIn: .constant(true)))),
            AppInfo(name: "Jackpot", imageName: "Jackpot", view: AnyView(JackpotView(isLoggedIn: .constant(true)))),
            AppInfo(name: "Traffic Light", imageName: "TrafficLight", view: AnyView(TrafficLightView(isLoggedIn: .constant(true)))),
            AppInfo(name: "Jeu de mémoire", imageName: "MemoryGame", view: AnyView(MemoryGameView(isLoggedIn: .constant(true)))),
            AppInfo(name: "Snake", imageName: "Snake", view: AnyView(SnakeGameView(isLoggedIn: .constant(true)))),
            AppInfo(name: "Flappy Bird", imageName: "FlappyBird", view: AnyView(FlappyBirdGameView(isLoggedIn: .constant(true))))
        ]
    }()

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()

            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Menu")

            ScrollView {
                VStack(spacing: 10) {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(apps, id: \.name) { app in
                            NavigationLink(destination: app.view) {
                                MenuItemView(appName: app.name, imageName: app.imageName)
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
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isLoggedIn: .constant(true))
    }
}
