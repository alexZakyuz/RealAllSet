//
//  ToDoClass.swift
//  RealAllSet
//
//  Created by Scholar on 7/30/25.
//

import Foundation
import SwiftData

@Model
class StoredTodo {
    @Attribute(.unique) var id: UUID
    var itemName: String  // Matches the string from the main list (e.g., "First")
    var text: String
    var isDone: Bool

    init(id: UUID = UUID(), itemName: String, text: String, isDone: Bool = false) {
        self.id = id
        self.itemName = itemName
        self.text = text
        self.isDone = isDone
    }
}

