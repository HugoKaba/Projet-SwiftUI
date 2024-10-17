import SwiftUI

struct GameControlsView: View {
    var changeDirection: (Direction) -> Void
    var startGameAction: () -> Void

    var body: some View {
        VStack {
            DirectionButtons(changeDirection: changeDirection)

            Button(action: {
                startGameAction()
            }) {
                Text("Start Game")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 30)
        }
    }
}
