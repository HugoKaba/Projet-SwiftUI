import SwiftUI
import CoreData

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var registrationSuccess: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
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
                            registerUser()
                        }) {
                            Text("Créer un compte")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)

                        Button(action: {dismiss()}) {
                            Text("Déjà un compte ? Se connecter")
                                .font(.system(size: 18, weight: .medium,design: .rounded))
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
    }

    private func registerUser() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let existingUsers = try viewContext.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                errorMessage = "Ce nom d'utilisateur est déjà pris."
                showError = true
                return
            }

            let newUser = User(context: viewContext)
            newUser.username = username
            newUser.password = password

            try viewContext.save()
            registrationSuccess = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                dismiss()
            }
        } catch {
            errorMessage = "Échec de l'inscription. Veuillez réessayer."
            showError = true
        }
    }
}

#Preview {
    RegisterView()
}
