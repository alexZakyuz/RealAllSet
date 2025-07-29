import SwiftUI
import SwiftData

struct NewToDoView: View {
    @Binding var showNewTask: Bool
    @Bindable var toDoItem: ToDoItem
    @Environment(\.modelContext) var modelContext
    
    // Binding to unwrap optional dueDate for DatePicker
    private var dueDateBinding: Binding<Date> {
        Binding<Date>(
            get: { toDoItem.dueDate ?? Date() },
            set: { toDoItem.dueDate = $0 }
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Task Title:")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Enter the task description...", text: $toDoItem.title)
                .padding()
                //.background(Color(.systemGroupedBackground))
                .cornerRadius(15)
            
            Toggle(isOn: $toDoItem.isImportant) {
                Text("Is it important?")
            }
            .padding(.horizontal)
            
            DatePicker("Due Date:", selection: dueDateBinding, displayedComponents: [.date, .hourAndMinute])
                .padding(.horizontal)
            
            Button {
                // Save & dismiss
                showNewTask = false
                dismissKeyboard()
            } label: {
                Text("Save")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(toDoItem.title.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(toDoItem.title.trimmingCharacters(in: .whitespaces).isEmpty)
            .padding(.horizontal)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
    
    func dismissKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}

#Preview {
    NewToDoView(showNewTask: .constant(true), toDoItem: ToDoItem(title: "", isImportant: false))
}

