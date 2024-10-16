import SwiftUI

struct CustomNavigationView: View {
    @Binding var isLoggedIn: Bool
    var title: String
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Spacer()

            HStack {
                Spacer()
                
                if title == "Menu" {
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                        isLoggedIn = false
                    }) {
                        Image(systemName: "power")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                } else {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                }
                
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
                .padding(.leading, 20)
                
                Spacer()
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    CustomNavigationView(isLoggedIn: .constant(true), title: "Menu")
}
