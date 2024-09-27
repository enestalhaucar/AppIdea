//
//  AppIdeaWidget.swift
//  AppIdeaWidget
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        SimpleEntry(date: Date(), appIdea: getAppIdeas())
    }
    
    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now, appIdea: getAppIdeas())], policy: .after(.now.advanced(by: 60 * 5)))
        completion(timeline)
    }
    
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), appIdea: getAppIdeas())
    }
    
//    @MainActor func snapshot(for configuration: ToggleFavoriteIntent, in context: Context, completion: @escaping (SimpleEntry) -> ())async -> SimpleEntry {
//        
//    }
//    
//    @MainActor func timeline(for configuration: ToggleFavoriteIntent, in context: Context, completion: @escaping (SimpleEntry)-> ()) async -> Timeline<SimpleEntry> {
//
//    }
    
    @MainActor private func getAppIdeas() -> [AppIdea] {
        
        guard let modelContainer = try? ModelContainer(for: AppIdea.self) else {
            return[]
        }
        let descriptor = FetchDescriptor<AppIdea>(predicate: #Predicate { idea in
            idea.isArchived == false
        })
        let appIdeas = try? modelContainer.mainContext.fetch(descriptor)
        return appIdeas ?? []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let appIdea : [AppIdea]
}

struct AppIdeaWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        
            HStack {
                VStack {
                    ForEach(entry.appIdea) { idea in
                        Button(intent: ToggleFavoriteIntent(appIdeaName: idea.name)) {
                            HStack {
                                Text(idea.name).foregroundStyle(.white)
                                Spacer()
                                Image(systemName: idea.isFavorite ? "star.fill" : "star").foregroundStyle(.yellow)
                            }.padding(.horizontal)
                        }              
                    }
                }
                VStack {
                    Image(systemName: "paperplane").foregroundStyle(.white).font(.title2)
                    Spacer()
                }.padding(.top,20)
            }.padding(.horizontal,20)

            
        
    }
}

struct AppIdeaWidget: Widget {
    let kind: String = "AppIdeaWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AppIdeaWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
                
                
                
        }.contentMarginsDisabled().supportedFamilies([.systemMedium])
    }
}



#Preview(as: .systemSmall) {
    AppIdeaWidget()
} timeline: {
    SimpleEntry(date: .now, appIdea: [])
    SimpleEntry(date: .now, appIdea: [])
}
