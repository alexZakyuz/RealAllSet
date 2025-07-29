import Foundation
import SwiftData

@Model
class ToDoItem {
    var title: String
    var isImportant: Bool
    var dueDate: Date?  // Added dueDate property
    
    init(title: String, isImportant: Bool = false, dueDate: Date? = nil) {
        self.title = title
        self.isImportant = isImportant
        self.dueDate = dueDate
    }
}

