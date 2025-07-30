//
//  LoginView.swift
//  RealAllSet
//
//  Created by Scholar on 7/30/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    @Environment(\.modelContext) private var context
    @State private var name = ""
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(Color("lightgreen"))
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(Color("vanilla").opacity(0.3))
                
                Circle()
                    .scale(1.35)
                    .foregroundColor(Color("vanilla"))
                
                VStack(alignment: .center) {
                    
                    Text("Welcome to All Set!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("What's your name?")
                        .font(.title2)
                        .padding([.leading, .top, .trailing])
                    
                    TextField("First name", text: $name)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(.black.opacity(0.05))
                        .cornerRadius(15)
                        .padding([.leading, .bottom, .trailing, .top])
                        .onSubmit {
                            
                            if !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                saveName()
                                
                            }//if statement
                            
                        }//onsubmit
                    
                    if !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        
                        Button("Save") {
                            
                            saveName()
                            
                        }//button
                        .padding()
                        .foregroundColor(Color("vanilla"))
                        .frame(width: 300, height: 50)
                        .background(Color("lightgreen"))
                        .cornerRadius(15)
                        .transition(.opacity.combined(with: .scale))
                        
                    }// if statement
                                        
                }//vstack
                .padding()
                .animation(.easeInOut(duration: 0.3), value: name.isEmpty)
                
            }//zstack
            
        }//navview
        
    }//body
    
    private func saveName() {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let user = User(name: trimmedName)
        context.insert(user)
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Failed to save user: \(error)")
            
        }//do
        
    }//func
    
}//struct


#Preview {
    
    LoginView()
        .modelContainer(for: User.self, inMemory: true)
    
}//preview
