import SwiftUI

struct DecreaseBetButtonView: View {
    let decreaseBet: () -> Void

    var body: some View {
        Button(action: decreaseBet) {
            Text("Diminuer mise")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
        }
        .padding(.top, 20)
    }
}
