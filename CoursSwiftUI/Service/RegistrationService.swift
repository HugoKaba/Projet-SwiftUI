import CoreData

protocol UserRegistration {
    func registerUser(username: String, password: String, context: NSManagedObjectContext) -> String?
}

class RegistrationService: UserRegistration {
    func registerUser(username: String, password: String, context: NSManagedObjectContext) -> String? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                return "Ce nom d'utilisateur est déjà pris."
            }

            let newUser = User(context: context)
            newUser.username = username
            newUser.password = password

            try context.save()
            return nil
        } catch {
            return "Échec de l'inscription. Veuillez réessayer."
        }
    }
}
