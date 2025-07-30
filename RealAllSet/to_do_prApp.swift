import SwiftUI
import SwiftData

//@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: ToDoItem.self)
        }
    }
}

