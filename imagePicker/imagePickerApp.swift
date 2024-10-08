//
//  imagePickerApp.swift
//  imagePicker
//
//  Created by sw on 08/10/24.
//

import SwiftUI

@main
struct imagePickerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
