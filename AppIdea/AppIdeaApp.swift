//
//  AppIdeaApp.swift
//  AppIdea
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import SwiftUI

@main
struct AppIdeaApp: App {
    var body: some Scene {
        WindowGroup {
            AppIdeaView()
                .modelContainer(for: [AppIdea.self, AppFeature.self], inMemory: false)
        }
    }
}
