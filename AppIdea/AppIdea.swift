//
//  AppIdea.swift
//  AppIdea
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import SwiftUI
import SwiftData

@Model
class AppIdea {
    @Attribute(.unique) var name : String
    var desc : String
    var dateCreated : Date
    var isArchived : Bool = false
    var isFavorite : Bool = false
    
    init(name: String, desc: String, isArchived: Bool = false, isFavorite : Bool = false) {
        self.name = name
        self.desc = desc
        self.dateCreated = .now
        self.isArchived = isArchived
        self.isFavorite = isFavorite
    }
    
    @Relationship(deleteRule: .cascade)
    var features : [AppFeature] = []
}
