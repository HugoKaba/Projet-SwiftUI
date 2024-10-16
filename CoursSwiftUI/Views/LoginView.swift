import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                GradientWaveBackground()
                    .ignoresSafeArea()

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
                .navigationDestination(isPresented: $isLoggedIn) {
                    MenuView()
                }
            }
        }
    }

    private func loginUser() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if !users.isEmpty {
                isLoggedIn = true
            } else {
                errorMessage = "Nom d'utilisateur ou mot de passe incorrect."
                showError = true
            }
        } catch {
            errorMessage = "Erreur lors de la tentative de connexion. Veuillez réessayer."
            showError = true
        }
    }
}

#Preview {
    LoginView()
}
