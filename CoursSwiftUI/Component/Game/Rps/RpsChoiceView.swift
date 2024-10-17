import SwiftUI

struct RpsChoicesView: View {
    let choices: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(choices, id: \.self) { choice in
                Button(action: {
                    onSelect(choice)
                }) {
                    Text(RpsEmojiUtils(for: choice))
                        .font(.system(size: 80))
                        .padding()
                        .background(Color.purple.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
        }
    }
}
