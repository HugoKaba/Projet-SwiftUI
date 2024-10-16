import XCTest
import CoreData
@testable import CoursSwiftUI

final class UserRegistrationServiceTests: XCTestCase {
    private var mockContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        let persistentContainer = NSPersistentContainer(name: "CoursSwiftUI")
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [storeDescription]
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Erreur lors du chargement du magasin de données : \(error)")
            }
        }
        mockContext = persistentContainer.viewContext
    }

    override func tearDown() {
        mockContext = nil
        super.tearDown()
    }

    func testUserRegistrationSuccess() {
        let registrationService = RegistrationService()
        let result = registrationService.registerUser(username: "newUser", password: "password123", context: mockContext)

        XCTAssertNil(result)

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", "newUser")

        do {
            let users = try mockContext.fetch(fetchRequest)
            XCTAssertEqual(users.count, 1)
        } catch {
            XCTFail("Échec de la récupération des utilisateurs : \(error)")
        }
    }

    func testUserRegistrationFailure() {
        let registrationService = RegistrationService()

        let existingUser = User(context: mockContext)
        existingUser.username = "existingUser"
        existingUser.password = "password123"

        do {
            try mockContext.save()
        } catch {
            XCTFail("Échec de l'enregistrement de l'utilisateur : \(error)")
        }

        let result = registrationService.registerUser(username: "existingUser", password: "newPassword", context: mockContext)

        XCTAssertEqual(result, "Ce nom d'utilisateur est déjà pris.")
    }
}
