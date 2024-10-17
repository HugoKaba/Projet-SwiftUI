import SwiftUI

struct ObstacleView: View {
    var obstacle: Obstacle
    var obstacleWidth: CGFloat
    var gap: CGFloat

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.green)
                .frame(width: obstacleWidth, height: obstacle.height)
                .position(x: obstacle.x, y: obstacle.height / 2)

            Rectangle()
                .fill(Color.green)
                .frame(width: obstacleWidth, height: UIScreen.main.bounds.height - obstacle.height - gap)
                .position(x: obstacle.x, y: obstacle.height + gap + (UIScreen.main.bounds.height - obstacle.height - gap) / 2)
        }
    }
}
