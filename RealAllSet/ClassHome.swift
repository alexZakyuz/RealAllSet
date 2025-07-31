//
//  ClassHome.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData
import Foundation

extension String: @retroactive Identifiable {
    public var id: String { self }
}

//ToDoListView for a project (String)

struct ToDoListView: View {
    
    @Environment(\.modelContext) var context
    let classes: String

    @Query var tasks: [Task]

    @State var newTaskTitle = ""
    @State var newTaskDueDate = Date()

    init(classes: String) {
        self.classes = classes
        // Set up the query dynamically using the `filter:` initializer
        _tasks = Query(filter: #Predicate<Task> { task in
            task.className == classes
        })}

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    TextField("New task...", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    DatePicker("Due Date", selection: $newTaskDueDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())

                    Button("Add Task") {
                        addTask()
                    }
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()

                List {
                    ForEach(tasks) { task in
                        HStack {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isDone ? .green : .gray)
                                .onTapGesture {
                                    toggleDone(task)
                                }
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .strikethrough(task.isDone)
                                Text("Due: \(task.dueDate, formatter: dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .navigationTitle(classes)
            .toolbar {
                EditButton()
            }
        }
    }

    func addTask() {
        let task = Task(title: newTaskTitle, dueDate: newTaskDueDate, className: classes)
        context.insert(task)
        try? context.save()
        newTaskTitle = ""
        newTaskDueDate = Date()
    }

    func toggleDone(_ task: Task) {
        task.isDone.toggle()
        try? context.save()
    }

    func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            context.delete(tasks[index])
        }
        try? context.save()
    }

}

//Main ContentView with String projects

struct ClassHome: View {
    @State var showInput = false
    @State var classList = ["geometry", "english", "history"]
  
    @State var newClass = " "
    @Environment(\.modelContext) var context

    @Query var tasks: [Task]

    @State var newTaskTitle = ""
    @State var newTaskDueDate = Date()

    
    

    @State private var selectedProject: String?

    var body: some View {
        VStack{
            NavigationView {
                List(classList, id: \.self) { course in
                    Button {
                        selectedProject = course
                    } label: {
                        Text(course)
                    }
                }
                .navigationTitle("Classes")
                .sheet(item: $selectedProject) { project in
                    ToDoListView(classes: project)
                }
                
            }
            Button(action: {showInput.toggle()}) {
                Text(showInput ? "Cancel" : "Create Class")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.56, green: 0.55, blue: 0.75)) // Muted purple
                    .foregroundColor(.black)
                    .cornerRadius(20)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            if showInput {
                VStack(spacing: 10){
                    TextField("Enter class name...", text: $newClass)
                        .foregroundStyle(.black)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Button("Submit (Enter class name ↑)"){if !newClass.isEmpty{
                        classList.append(newClass)
                        newClass = " "
                        showInput = false}
                    }
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.56, green: 0.55, blue: 0.75)) // Muted purple
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .padding()
                    .cornerRadius(8)

                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .init("ResetClassList"))) { _ in
            classList = [] // Reset to default classes
        }
        }
        
}

//DateFormatter for due date display

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

//Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClassHome()
            .modelContainer(for: Task.self, inMemory: true)
    }
}
