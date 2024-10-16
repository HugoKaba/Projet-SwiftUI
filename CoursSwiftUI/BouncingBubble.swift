import SwiftUI

struct BouncingBubbleView: View {
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                .edgesIgnoringSafeArea(.all)

            ForEach(0..<20) { _ in
                BouncingBubble()
            }
        }
    }
}

struct BouncingBubble: View {
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var size: CGFloat = CGFloat.random(in: 30...70)
    @State private var direction: CGSize = CGSize.zero

    private var color: Color {
        Color(hue: Double.random(in: 0...1), saturation: 1, brightness: 1)
    }

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .position(position)
            .onAppear {
                resetPosition()
                startBouncing()
            }
    }

    private func resetPosition() {
        position = CGPoint(x: CGFloat.random(in: size...(UIScreen.main.bounds.width - size)),
                           y: CGFloat.random(in: size...(UIScreen.main.bounds.height - size)))
    }

    private func startBouncing() {
        direction = CGSize(width: CGFloat.random(in: -2...2), height: CGFloat.random(in: -2...2))

        withAnimation(.linear(duration: 0.02).repeatForever(autoreverses: false)) {
            updatePosition()
        }
    }

    private func updatePosition() {
        position.x += direction.width
        position.y += direction.height

        if position.x <= size / 2 || position.x >= UIScreen.main.bounds.width - size / 2 {
            direction.width = -direction.width
        }
        if position.y <= size / 2 || position.y >= UIScreen.main.bounds.height - size / 2 {
            direction.height = -direction.height
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            updatePosition()
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)

        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
