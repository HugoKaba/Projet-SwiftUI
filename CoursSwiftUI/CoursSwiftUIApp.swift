//
//  CoursSwiftUIApp.swift
//  CoursSwiftUI
//
//  Created by hugo Kaba on 15/10/2024.
//

import SwiftUI

@main
struct CoursSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
