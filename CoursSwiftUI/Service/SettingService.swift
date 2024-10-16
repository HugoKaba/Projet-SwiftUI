import Foundation

class SettingsService: ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: "email")
        }
    }
    
    init() {
        self.username = UserDefaults.standard.string(forKey: "username") ?? "User123"
        self.email = UserDefaults.standard.string(forKey: "email") ?? "user@example.com"
    }
}
