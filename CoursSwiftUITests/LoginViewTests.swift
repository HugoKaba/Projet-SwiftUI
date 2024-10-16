import XCTest
import CoreData
@testable import CoursSwiftUI

final class AuthenticationServiceTests: XCTestCase {
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
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
    }

    override func tearDown() {
        mockContext = nil
        super.tearDown()
    }

    func testSuccessfulLogin() {
        let authenticationService = AuthenticationService()
        
        let user = User(context: mockContext)
        user.username = "testUser"
        user.password = "testPassword"

        do {
            try mockContext.save()
        } catch {
            XCTFail("Échec de l'enregistrement de l'utilisateur : \(error)")
        }
        
        let result = authenticationService.login(username: "testUser", password: "testPassword", context: mockContext)

        XCTAssertNil(result)
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "isLoggedIn"))
    }

    func testFailedLoginWithIncorrectCredentials() {
        let authenticationService = AuthenticationService()
        let result = authenticationService.login(username: "wrongUser", password: "wrongPassword", context: mockContext)

        XCTAssertEqual(result, "Nom d'utilisateur ou mot de passe incorrect.")
        XCTAssertFalse(UserDefaults.standard.bool(forKey: "isLoggedIn"))
    }
}
