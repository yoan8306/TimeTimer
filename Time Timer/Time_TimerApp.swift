//
//  Time_TimerApp.swift
//  Time Timer
//
//  Created by Yoan on 31/03/2023.
//

import SwiftUI

@main
struct Time_TimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
