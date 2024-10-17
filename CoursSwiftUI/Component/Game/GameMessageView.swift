import SwiftUI

struct GameMessageView: View {
    var message: String

    var body: some View {
        if !message.isEmpty {
            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 10)
        }
    }
}
