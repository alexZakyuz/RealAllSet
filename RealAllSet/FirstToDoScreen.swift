import SwiftUI
import SwiftData

struct FirstToDoScreen: View {
    @State private var showNewTask = false
    @State private var newToDoItem: ToDoItem? = nil

    @Query var toDos: [ToDoItem]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationView {
            ZStack {
                Color(Color("beigebrown"))
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text("To-Do List")
                            .font(.system(size: 40))
                            .fontWeight(.black)
                        Spacer()
                        Button {
                            let item = ToDoItem(title: "", isImportant: false)
                            modelContext.insert(item)
                            newToDoItem = item
                            withAnimation {
                                showNewTask = true
                            }
                        } label: {
                            Text("+")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()

                    List {
                        ForEach(toDos) { item in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.isImportant ? "‼️ \(item.title)" : item.title)
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                if let due = item.dueDate {
                                    Text("Due: \(due.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(item.isImportant ? Color.red.opacity(0.3) : Color.white.opacity(0.3))
                            .cornerRadius(10)
                        }
                        .onDelete(perform: deleteToDo)
                    }
                    .listStyle(.plain)
                    .background(Color.clear)
                }
            }
            .sheet(isPresented: $showNewTask) {
                if let newToDoItem = newToDoItem {
                    NewToDoView(showNewTask: $showNewTask, toDoItem: newToDoItem)
                }
            }
        }
    }

    func deleteToDo(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(toDos[offset])
        }
    }
}

#Preview {
    ContentView(userName: "Test User")
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
