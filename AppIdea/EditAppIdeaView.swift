//
//  EditAppIdeaView.swift
//  AppIdea
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import SwiftUI
import SwiftData

struct EditAppIdeaView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var idea : AppIdea
    @State private var newFeatureDesc = ""
    var body: some View {
        Form {
            TextField("Name", text: $idea.name)
            
            TextField("Description", text: $idea.desc, axis: .vertical)
            
            Section("Feature") {
                TextField("New Feature", text: $newFeatureDesc)
                    .onSubmit {
                        let feature = AppFeature(desc: newFeatureDesc)
                        idea.features.append(feature)
                        newFeatureDesc.removeAll()
                    }
                
                ForEach(idea.features) { feature in
                    Text(feature.desc)
                        .contextMenu {
                            Button(role: .destructive) {
                                idea.features.removeAll(where: {$0 == feature})
                                modelContext.delete(feature)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
        }.navigationTitle(idea.name)
    }
}


