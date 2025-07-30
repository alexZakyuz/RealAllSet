//
//  RealAllSetApp.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData

@main
struct RealAllSetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: NewName.self)
        }
    }
}
