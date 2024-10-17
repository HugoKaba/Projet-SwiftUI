import SwiftUI

struct SpinButtonView: View {
    let betAmount: Int
    let credits: Int
    let spinAction: () -> Void
    let errorMessage: () -> Void

    var body: some View {
        Button(action: {
            if betAmount > credits {
                errorMessage()
            } else {
                spinAction()
            }
        }) {
            Text("Miser \(betAmount) crédits")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}
