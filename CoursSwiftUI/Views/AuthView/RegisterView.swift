import SwiftUI
import CoreData

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @Environment(\.dismiss) var dismiss

    private var registrationService: UserRegistration

    init(registrationService: UserRegistration = RegistrationService()) {
        self.registrationService = registrationService
    }

    var body: some View {
        ZStack {
            GradientWaveBackground()
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("S'inscrire")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 30)

                    CustomTextField(placeholder: "Nom d'utilisateur", text: $username)
                    CustomSecureField(placeholder: "Mot de passe", text: $password)

                    CustomButton(title: "Créer un compte", action: registerUser)

                    Button(action: dismiss.callAsFunction) {
                        Text("Déjà un compte ? Se connecter")
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
                Alert(title: Text("Erreur"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func registerUser() {
        if let errorMessage = registrationService.registerUser(username: username, password: password, context: viewContext) {
            showError(with: errorMessage)
        } else {
            dismiss()
        }
    }

    private func showError(with message: String) {
        errorMessage = message
        showError = true
    }
}

#Preview {
    RegisterView()
}
