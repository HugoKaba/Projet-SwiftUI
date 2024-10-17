import SwiftUI

struct TrafficLightIndicator: View {
    var lights: [TrafficLightState]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<3) { index in
                Circle()
                    .foregroundColor(lights[index] == .green ? .green : .red)
                    .frame(width: 80, height: 80)
            }
        }
    }
}

