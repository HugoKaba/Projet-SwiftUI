import SwiftUI

struct MenuView: View {
    let appNames = (1...20).map { "App \($0)" }
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            
            NavigationView(isLoggedIn: $isLoggedIn)
            
            ScrollView {
                VStack(spacing: 10) {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(appNames, id: \.self) { appName in
                            NavigationLink(destination: EmptyView()) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(
                                                colors: [
                                                    Color.blue.opacity(0.7),
                                                    Color.purple.opacity(0.7)
                                                ]),
                                            startPoint:
                                                    .topLeading,endPoint:
                                                    .bottomTrailing
                                        ))
                                    .frame(height: 120)
                                    .overlay(
                                        VStack {
                                            Image("Box")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(
                                                    width: 40,
                                                    height: 40
                                                )
                                                .foregroundColor(
                                                    .white.opacity(0.8)
                                                )
                                            
                                            Text(appName)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .padding(.top, 5)
                                        }
                                    )
                                    .shadow(
                                        color:Color.black.opacity(0.2),
                                        radius: 5, x: 0, y: 5
                                    )
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.70)
        }
    }
}

#Preview {
    MenuView(isLoggedIn: .constant(true))
}
