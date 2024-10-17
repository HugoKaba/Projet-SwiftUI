import SwiftUI

struct GradientWaveBackground: View {
    @Environment(\.dismiss) var dismiss    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                Spacer()

                ZStack {
                    WaveShape(yOffset: 0.4)
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 200)
                        .offset(y: 50)
                    
                    WaveShape(yOffset: 0.35)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 220)
                        .offset(y: 80)
                    
                    WaveShape(yOffset: 0.3)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 240)
                        .offset(y: 110)
                }
                .ignoresSafeArea()
            }
        }
    }
}

struct WaveShape: Shape {
    var yOffset: CGFloat
    
    var animatableData: CGFloat {
        get { yOffset }
        set { yOffset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let height = rect.height
        let width = rect.width
        
        path.move(to: CGPoint(x: 0, y: height * yOffset))
        
        path.addCurve(
            to: CGPoint(x: width, y: height * yOffset),
            control1: CGPoint(x: width * 0.25, y: height * (yOffset + 0.1)),
            control2: CGPoint(x: width * 0.75, y: height * (yOffset - 0.1))
        )
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    GradientWaveBackground()
}
