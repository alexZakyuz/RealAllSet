//
//  ClassHome.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct ClassHome: View {
    // Sample classes
    let classes = ["English", "Algebra", "History", "Band", "PE"]
    
    // Date formatter
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color from screenshot
                Color(Color("vanilla"))
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
                    // Top bar
                    HStack {
                        Text("Classes")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(formattedDate)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                    
                    // Class list
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(classes, id: \.self) { className in
                            Text("• \(className)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .underline()
                                .foregroundColor(Color(red: 0.13, green: 0.05, blue: 0.23)) // Dark purple
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Create Class button -> Navigates to NewClass
                    NavigationLink(destination: NewClass()) {
                        Text("Create Class")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.56, green: 0.55, blue: 0.75)) // Muted purple
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .padding(.top)
            }
        }
    }
}



#Preview {
    ClassHome()
}
