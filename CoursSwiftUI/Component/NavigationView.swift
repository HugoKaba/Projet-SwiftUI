import SwiftUI

struct NavigationView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Text("Accueil")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    isLoggedIn = false
                }) {
                    Image(systemName: "power")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
                Spacer()
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    NavigationView(isLoggedIn: .constant(true))
}
