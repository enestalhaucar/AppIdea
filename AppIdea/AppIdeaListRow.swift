//
//  AppIdeaListRow.swift
//  AppIdea
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import SwiftUI

struct AppIdeaListRow: View {
    @Environment(\.modelContext) private var modelContext
    var idea : AppIdea
    var body: some View {
        NavigationLink(value: idea) {
            VStack(alignment: .leading) {
                Text(idea.name)
                    .foregroundStyle(.primary)
                Text(idea.desc)
                    .textScale(.secondary)
                    .foregroundStyle(.secondary)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                modelContext.delete(idea)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button() {
                idea.isFavorite.toggle()
            } label: {
                Label("Favorite", systemImage: idea.isFavorite ? "star.slash" : "star")
            }.tint(.yellow)
            
            Button() {
                idea.isArchived = true
            } label: {
                Label("Archive", systemImage: "archivebox")
            }.tint(.indigo)
            
            
        }
        .sensoryFeedback(.decrease, trigger: idea.isArchived)
        .sensoryFeedback(.increase, trigger: idea.isFavorite)
    }
}


