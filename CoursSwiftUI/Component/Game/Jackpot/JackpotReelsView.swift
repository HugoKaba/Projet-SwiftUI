import SwiftUI

struct JackpotReelsView: View {
    let reels: [Int]
    let symbols: [String]

    var body: some View {
        HStack {
            ForEach(reels, id: \.self) { reel in
                Text(symbols[reel])
                    .font(.system(size: 80))
                    .padding()
                    .background(Gradient(
                        colors: [
                            Color.purple.opacity(0.9),
                            Color.pink.opacity(0.4),
                            Color.purple.opacity(0.9)
                        ])
                    )
                    .cornerRadius(10)
            }
        }
        .frame(height: 150)
    }
}
