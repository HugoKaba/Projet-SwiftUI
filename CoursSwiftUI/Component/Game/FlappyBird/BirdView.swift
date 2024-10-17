import SwiftUI

struct BirdView: View {
    var birdX: CGFloat
    var birdY: CGFloat

    var body: some View {
        Text("🐥")
            .font(.system(size: 40))
            .position(x: birdX, y: birdY)
    }
}
