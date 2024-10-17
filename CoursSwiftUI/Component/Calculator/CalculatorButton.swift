import SwiftUI

struct CalculatorButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.largeTitle)
                .frame(width: 70, height: 70)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(35)
                .foregroundColor(.white)
        }
    }
}
