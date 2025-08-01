//
//  SettingsView.swift
//  RealAllSet
//
//  Created by Scholar on 7/31/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    @Binding var isDarkMode: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query private var users: [User]
    
    @State private var showingNameEdit = false
    @State private var showingResetAlert = false
    @State private var tempUserName: String = ""
    
    private var userName: String {
        users.first?.name ?? "User"
    }
    
    var body: some View {
        
        //NavigationView {
            
            Form {
                
                Section("Appearance") {
                    
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    
                }//section
                
                Section("Profile") {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(userName)
                            .foregroundColor(.secondary)
                        Button {
                            tempUserName = userName
                            showingNameEdit = true
                        } label: {
                            Text("Edit")
                        }
                    }//hstack
                }//section
                
                Section("About") {
                    
                    HStack {
                        
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                        
                    }//hstack
                    
                }//section
                                
                Section {
                    
                    Button("Reset All Settings") {
                        
                        showingResetAlert = true
                        
                    }//button
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }//section
                
            }//form
            .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }//button
                }//toolbaritem
            }//toolbar
            .alert("Edit Name", isPresented: $showingNameEdit) {
                TextField("Enter your name", text: $tempUserName)
                Button("Cancel", role: .cancel) { }
                Button("Save") {
                    updateUserName()
                }//button
            } message: {
                Text("Enter your display name")
            }//alert
            .alert("Reset Settings", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    resetAllSettings()
                }//button
            } message: {
                Text("This will reset all settings to their default values. This action cannot be undone.")
            }//button
            
        //}//navview
        
    }//body
    
    private func updateUserName() {
        
        let trimmedName = tempUserName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        
        if let user = users.first {
            
            user.name = trimmedName
            
            do {
                
                try context.save()
                
            } catch {
                
                print("Failed to update user name: \(error)")
                
            }//do
            
        }//if statement
        
    }//func
    
    private func resetAllSettings() {
        isDarkMode = false
        
        //delete calendar notes
        UserDefaults.standard.removeObject(forKey: "savedNotes")
        NotificationCenter.default.post(name: .init("ResetCalendarNotes"), object: nil)
        
        // Clear volunteer entries
        UserDefaults.standard.removeObject(forKey: "volunteerEntries")
        NotificationCenter.default.post(name: .init("ResetVolunteerEntries"), object: nil)
        
        //Clear volunteer goal
        UserDefaults.standard.removeObject(forKey: "volunteerGoal")
        
        // Clear all SwiftData tasks from database
        do {
            let fetchDescriptor = FetchDescriptor<Task>()
            let allTasks = try context.fetch(fetchDescriptor)
            for task in allTasks {
                context.delete(task)
            }
            try context.save()
        } catch {
            print("Failed to delete tasks: \(error)")
        }
        
        // Clear all SwiftData courses from database (if any exist)
        do {
            let fetchDescriptor = FetchDescriptor<Course>()
            let allCourses = try context.fetch(fetchDescriptor)
            for course in allCourses {
                context.delete(course)
            }
            try context.save()
        } catch {
            print("Failed to delete courses: \(error)")
        }
        
        // Clear class list from AppStorage directly
        UserDefaults.standard.removeObject(forKey: "classList")
        
        // Reset class list to default
        NotificationCenter.default.post(name: .init("ResetClassList"), object: nil)
        
        // Delete the user from SwiftData to return to LoginView
        do {
            let fetchDescriptor = FetchDescriptor<User>()
            let allUsers = try context.fetch(fetchDescriptor)
            for user in allUsers {
                context.delete(user)
            }
            try context.save()
            
            // Dismiss the settings view since we're going back to login
            dismiss()
        } catch {
            print("Failed to delete user: \(error)")
        }
    }//func
    
}//struct


#Preview {
    
    SettingsView(isDarkMode: .constant(false))
        .modelContainer(for: User.self, inMemory: true)
    
}//preview
