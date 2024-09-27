//
//  ContentView.swift
//  AppIdea
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import SwiftUI
import SwiftData

struct AppIdeaView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<AppIdea> { idea in idea.isArchived == false }, sort: \.dateCreated, order: .reverse) var ideas: [AppIdea]
    
    var favoriteIdeas : [AppIdea]  {
        ideas.filter{$0.isFavorite}
    }
    var nonFavoriteIdeas : [AppIdea]  {
        ideas.filter{$0.isFavorite == false}
    }
    @State private var showAddIdea : Bool = false

    @State private var newName = ""
    @State private var newDesc = ""
    
    var body: some View {
            NavigationStack {
                Group{
                    if ideas.isEmpty {
                        ContentUnavailableView("No App Ideas", systemImage: "square.stack.3d.up.slash", description: Text("Tap add to create your first App Idea."))
                    } else {
                        List{
                            Section("Favorites") {
                                ForEach(favoriteIdeas) {
                                    AppIdeaListRow(idea : $0)
                                }
                            }
                            Section("All") {
                                ForEach(nonFavoriteIdeas) {
                                    AppIdeaListRow(idea : $0)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("App Ideas")
                .navigationDestination(for: AppIdea.self) {
                    EditAppIdeaView(idea : $0)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddIdea.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                        }
                    }
                    
                }
                .sheet(isPresented: $showAddIdea) {
                    NavigationStack {
                        Form {
                            TextField("Name", text: $newName)
                            TextField("Description", text: $newDesc)
                        }
                        .navigationTitle("New App Idea")
                        .toolbar {
                            Button("Dismiss") {
                                showAddIdea.toggle()
                            }
                            Button("Save") {
                                let idea = AppIdea(name: newName, desc: newDesc, isArchived: false)
                                modelContext.insert(idea)
                                showAddIdea.toggle()
                                
                            }
                        }
                    }.presentationDetents([.medium])
                }
                
            }
    }
}

#Preview {
    AppIdeaView()
        .modelContainer(for: [AppIdea.self, AppFeature.self], inMemory: false)
}
