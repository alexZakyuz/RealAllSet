//
//  ClassHome.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData



struct Todo: Identifiable {
    let id = UUID()
    var text: String
    var isDone: Bool = false
}

struct ClassHome: View {
    
    @State var classes = ["English", "Algebra", "History", "Band", "PE"]
    
    // Track modal state per item string
    @State private var sheetStates: [String: Bool] = [:]
    
    // Track to-do list per item string
    @State private var todosByItem: [String: [Todo]] = [:]
    
    var body: some View {
        ZStack{
            Color(Color("vanilla"))
                .edgesIgnoringSafeArea(.all)
            VStack{
                List(classes, id: \.self) { item in
                    Button("• \(item)") {
                        sheetStates[item] = true
                        
                        if todosByItem[item] == nil {
                            todosByItem[item] = []
                        }
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .underline()
                    .foregroundColor(Color(red: 0.13, green: 0.05, blue: 0.23)) // Dark purple
                    .backgroundStyle(Color("vanilla"))
                    
                    .sheet(isPresented: Binding(
                        get: { sheetStates[item] ?? false },
                        set: { sheetStates[item] = $0 }
                    )) {
                        TodoListModalView(
                            itemName: item,
                            todos: Binding(
                                get: { todosByItem[item] ?? [] },
                                set: { todosByItem[item] = $0 }
                            )
                        )
                    }
                }
            }
            
            .onAppear {
                for item in classes {
                    sheetStates[item] = false
                    todosByItem[item] = []
                }
            }
        }
    }
}

struct TodoListModalView: View {
    let itemName: String
    @Binding var todos: [Todo]
    @Environment(\.dismiss) var dismiss
    
    @State private var newTodoText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New To-Do", text: $newTodoText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTodo) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(newTodoText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
                
                List {
                    ForEach($todos) {$todo in
                        HStack {
                            Button(action: {
                                todo.isDone.toggle()
                            }) {
                                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.isDone ? .green : .gray)
                            }
                            Text(todo.text)
                                .strikethrough(todo.isDone)
                        }
                    }
                    .onDelete(perform: deleteTodos)
                }
            }
            .navigationTitle("\(itemName)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addTodo() {
        let trimmed = newTodoText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        todos.append(Todo(text: trimmed))
        newTodoText = ""
    }
    
    func deleteTodos(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}



#Preview{
    ClassHome()
}
