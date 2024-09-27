//
//  AppFeature.swift
//  AppIdea
//
//  Created by Enes Talha Uçar  on 27.09.2024.
//

import SwiftData
import SwiftUI


@Model
class AppFeature {
    @Attribute(.unique) var desc : String
    var dateCreated : Date
    
    init(desc: String) {
        self.desc = desc
        self.dateCreated = .now
    }
    
    
}
