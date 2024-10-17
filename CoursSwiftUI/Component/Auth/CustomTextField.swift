import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.7)))
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .foregroundColor(.black)
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .padding(.horizontal, 10)
    }
}
