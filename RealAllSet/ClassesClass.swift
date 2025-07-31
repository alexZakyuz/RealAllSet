//
//  ClassesClass.swift
//  RealAllSet
//
//  Created by Scholar on 7/31/25.
//

import Foundation
import SwiftData

@Model
class Task {
    var title: String
    var dueDate: Date
    var isDone: Bool
    var className: String

    init(title: String, dueDate: Date, isDone: Bool = false, className: String) {
        self.title = title
        self.dueDate = dueDate
        self.isDone = isDone
        self.className = className
    }
}

class Class{
    var className: String
    init(className: String){
        self.className = className
    }
}


