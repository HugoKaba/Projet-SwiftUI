import SwiftUI

struct JackpotView: View {
    @ObservedObject var game = JackpotService()
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            CustomNavigationView(isLoggedIn: $isLoggedIn, title: "Jackpot 🍀")
            VStack {
//                Spacer()

                VStack {
                    Text("Crédits: \(game.credits)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    HStack {
                        ForEach(game.reels, id: \.self) { reel in
                            Text(game.symbols[reel])
                                .font(.system(size: 80))
                                .padding()
                                .background(Color.purple.opacity(0.3))
                                .cornerRadius(10)
                        }
                    }
                    .frame(height: 150)

                    if !game.message.isEmpty {
                        Text(game.message)
                            .font(.title)
                            .foregroundColor(.white)

                    }

                    Spacer()

                    HStack {
                        Button(action: {
                            if game.betAmount > game.credits {
                                game.message = "Pas assez de crédits!"
                            } else {
                                game.spinReels()
                            }
                        }) {
                            Text("Miser \(game.betAmount) crédits")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.purple)
                                .cornerRadius(10)
                        }
                    }
                    Text("Choisir une mise:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    HStack {
                        Button(action: { game.increaseBet(by: 5) }) {
                            Text("+5")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                        Button(action: { game.increaseBet(by: 10) }) {
                            Text("+10")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                        Button(action: { game.increaseBet(by: 20) }) {
                            Text("+20")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 10)

                    Button(action: {
                        game.decreaseBet()
                    }) {
                        Text("Diminuer mise")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)

                    Button("Réinitialiser") {
                        game.resetGame()
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.bottom, 70)
        }
    }
}

#Preview {
    JackpotView(isLoggedIn: .constant(true))
}
