import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""
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

                CustomTextField(placeholder: "Nom d'utilisateur", text: $username)
                CustomSecureField(placeholder: "Mot de passe", text: $password)

                CustomButton(title: "Se connecter", action: loginUser)

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
        .onAppear(perform: checkLoginStatus)
    }

    private func loginUser() {
        if let error = authenticationService.login(username: username, password: password, context: viewContext) {
            showError(with: error)
        } else {
            isLoggedIn = true
        }
    }

    private func checkLoginStatus() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            isLoggedIn = true
            username = UserDefaults.standard.string(forKey: "loggedInUsername") ?? ""
        }
    }

    private func showError(with message: String) {
        errorMessage = message
        showError = true
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
