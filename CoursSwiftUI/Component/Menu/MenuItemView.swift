import SwiftUI

struct MenuItemView: View {
    let appName: String
    let imageName: String

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.pink.opacity(0.7),
                        Color.purple.opacity(0.7)
                    ]),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
            .frame(height: 120)
            .overlay(
                VStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white.opacity(0.8))

                    Text(appName)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top, 5)
                }
            )
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 10)
    }
}
