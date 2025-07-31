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
    
    @State private var userName: String = "User"
    @State private var showingNameEdit = false
    @State private var showingResetAlert = false
    @State private var tempUserName: String = ""
    
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
                    if !tempUserName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        userName = tempUserName.trimmingCharacters(in: .whitespacesAndNewlines)
                    }//if statement
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
    
    private func resetAllSettings() {
        isDarkMode = false
        userName = "User"
        
        //delete calendar notes
        UserDefaults.standard.removeObject(forKey: "savedNotes")
        NotificationCenter.default.post(name: .init("ResetCalendarNotes"), object: nil)
        
        // Clear volunteer entries
        UserDefaults.standard.removeObject(forKey: "volunteerEntries")
        NotificationCenter.default.post(name: .init("ResetVolunteerEntries"), object: nil)
        
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
        
        // Reset class list to default
        NotificationCenter.default.post(name: .init("ResetClassList"), object: nil)
    }//func
    
}//struct


#Preview {
    
    SettingsView(isDarkMode: .constant(false))
        .modelContainer(for: User.self, inMemory: true)
    
}//preview
