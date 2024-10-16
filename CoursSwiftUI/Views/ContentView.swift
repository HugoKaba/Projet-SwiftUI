import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some View {
        NavigationStack {
            ZStack{
                GradientWaveBackground()
                    .ignoresSafeArea()
                if !isLoggedIn {
                    LoginView(isLoggedIn: $isLoggedIn)
                } else {
                    MenuView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
