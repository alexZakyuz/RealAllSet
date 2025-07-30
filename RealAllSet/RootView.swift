//
//  RootView.swift
//  RealAllSet
//
//  Created by Scholar on 7/30/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    
    var body: some View {
        Group {
            if let user = users.first {
                ContentView(userName: user.name)
            } else {
                LoginView()
            }
        }//group
    }//body
}//struct

#Preview {
    RootView()
        .modelContainer(for: User.self, inMemory: true)
}
