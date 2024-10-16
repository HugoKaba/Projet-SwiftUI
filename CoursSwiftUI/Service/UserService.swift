import Foundation
import CoreData

class UserService: ObservableObject {
    @Published var currentUser: User?

    init() {
        fetchCurrentUser()
    }

    private func fetchCurrentUser() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            currentUser = users.first
        } catch {
            print("Failed to fetch user: \(error)")
        }
    }

    func updateUser(username: String, password: String?) -> Bool {
        guard let user = currentUser else {
            print("Current user is nil.")
            return false
        }
        
        user.username = username
        
        if let newPassword = password, !newPassword.isEmpty {
            user.password = newPassword
        }

        do {
            let context = PersistenceController.shared.container.viewContext
            try context.save()
            print("User saved successfully.")
            return true
        } catch {
            print("Failed to save user: \(error)")
            return false
        }
    }
}
