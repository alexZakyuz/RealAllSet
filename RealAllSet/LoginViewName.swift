//
//  LoginViewName.swift
//  AllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData

struct LoginViewName: View {
    
    @State private var name = ""
    
    var body: some View {
        
        NavigationStack {
            
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
                                        
                    if name != "" {
                        
                        NavigationLink {
                            
                            ContentView()
                            
                        } label: {
                            
                            Text("Next")
                                .padding()
                                .foregroundColor(Color("vanilla"))
                                .frame(width: 300, height: 50)
                                .background(Color("lightgreen"))
                                .cornerRadius(15)
                            
                        }//navlink
                        
                    }//if statement
                    
                }//vstack
                
            }//zstack
            
        }//navstack
        
    }//body
    
}//struct


#Preview {
    
    LoginViewName()
    
}//preview
