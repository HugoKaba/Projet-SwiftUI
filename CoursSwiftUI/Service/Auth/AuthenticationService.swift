import CoreData

protocol Authentication {
    func login(username: String, password: String, context: NSManagedObjectContext) -> String?
}

class AuthenticationService: Authentication {
    func login(username: String, password: String, context: NSManagedObjectContext) -> String? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
            let users = try context.fetch(fetchRequest)
            if !users.isEmpty {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(username, forKey: "loggedInUsername")
                return nil
            } else {
                return "Nom d'utilisateur ou mot de passe incorrect."
            }
        } catch {
            return "Erreur lors de la tentative de connexion. Veuillez réessayer."
        }
    }
}
