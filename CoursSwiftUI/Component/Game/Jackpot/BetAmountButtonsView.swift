import SwiftUI

struct BetAmountButtonsView: View {
    let increaseBet: (Int) -> Void
    let betAmounts = [5, 10, 20]

    var body: some View {
        HStack {
            ForEach(betAmounts, id: \.self) { amount in
                Button(action: { increaseBet(amount) }) {
                    Text("+\(amount)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}
