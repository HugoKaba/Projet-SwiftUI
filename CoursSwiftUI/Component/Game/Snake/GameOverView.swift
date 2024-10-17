import SwiftUI

struct GameOverView: View {
    var restartAction: () -> Void

    var body: some View {
        VStack {
            Text("Game Over!")
                .font(.headline)
                .foregroundColor(.red)
                .padding(.bottom, 10)

            Button(action: {
                restartAction()
            }) {
                Text("Restart")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
