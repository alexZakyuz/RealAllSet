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
            
            RootView()
            
        }//windowgroup
        .modelContainer(for: User.self)

    }//body
    
}//struct
