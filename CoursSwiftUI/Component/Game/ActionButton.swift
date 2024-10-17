import SwiftUI

struct ActionButton: View {
    let title: String
    let action: () -> Void
    let isActive: Bool
    let buttonColor: AnyView

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(buttonColor)
                .cornerRadius(10)
                .opacity(isActive ? 1 : 0.5)
                .disabled(!isActive)
        }
    }
}
