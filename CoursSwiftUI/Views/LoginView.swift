import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var username: String = ""
    @State var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @Binding var isLoggedIn: Bool

    private var authenticationService: Authentication

    init(authenticationService: Authentication = AuthenticationService(), isLoggedIn: Binding<Bool>) {
        self.authenticationService = authenticationService
        self._isLoggedIn = isLoggedIn
    }

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 20) {
                Text("Connexion")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)

                TextField("", text: $username, prompt: Text("Nom d'utilisateur").foregroundColor(.gray.opacity(0.7)))
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .padding(.horizontal, 10)

                SecureField("", text: $password, prompt: Text("Mot de passe").foregroundColor(.gray.opacity(0.7)))
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .padding(.horizontal, 10)

                Button(action: {
                    loginUser()
                }) {
                    Text("Se connecter")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .padding(.top, 20)

                NavigationLink(destination: RegisterView()) {
                    Text("S'inscrire")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(Color.white)
                }
                .padding(.top, 10)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(15)
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding()
        .alert(isPresented: $showError) {
            Alert(title: Text("Erreur de connexion"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            checkLoginStatus()
        }
    }

    func loginUser() {
        if let error = authenticationService.login(username: username, password: password, context: viewContext) {
            errorMessage = error
            showError = true
        } else {
            isLoggedIn = true
        }
    }

    private func checkLoginStatus() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            isLoggedIn = true
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isLoggedIn = false
        
        var body: some View {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
    return PreviewWrapper()
}
