import SwiftUI

struct SettingsView: View {
    @ObservedObject var userService = UserService()
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    HStack {
                        Text("Username")
                        Spacer()
                        TextField("Username", text: $newUsername)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.gray)
                            .onAppear {
                                newUsername = userService.currentUser?.username ?? ""
                            }
                    }
                    
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Password", text: $newPassword)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.gray)
                            .onAppear {
                                newPassword = userService.currentUser?.password ?? ""
                            }
                    }
                }
                
                Section {
                    Button(action: saveSettings) {
                        Text("Save Settings")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func saveSettings() {
        guard !newUsername.isEmpty else {
            alertMessage = "Username cannot be empty."
            showAlert = true
            return
        }

        let success = userService.updateUser(username: newUsername, password: newPassword.isEmpty ? nil : newPassword)

        if success {
            alertMessage = "Settings saved successfully."
        } else {
            alertMessage = "Failed to save settings. Please try again."
        }
        showAlert = true
    }
}

#Preview {
    SettingsView()
}
