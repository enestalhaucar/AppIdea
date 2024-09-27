//
//  AppIntent.swift
//  AppIdeaWidget
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import WidgetKit
import AppIntents
import SwiftData

struct ToggleFavoriteIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Favorite"
    static var description = IntentDescription("Toggle Favorite")
    // An example configurable parameter.
    @Parameter(title: "App Idea Name")
    var appIdeaName: String
    init() {
        
    }
    init(appIdeaName: String) {
        self.appIdeaName = appIdeaName
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        guard let modelContainer = try? ModelContainer(for: AppIdea.self) else {
            return .result()
        }
        let descriptor = FetchDescriptor<AppIdea>(predicate: #Predicate { idea in
            idea.name == appIdeaName
        })
        let appIdeas = try?  modelContainer.mainContext.fetch(descriptor)
        
        if let idea = appIdeas?.first {
            // Toggle the isFavorite property
                   idea.isFavorite.toggle()

                   // Save changes to the model container
                   try? modelContainer.mainContext.save()
        }
        
        
        
        return .result()
    }

    
    
}
