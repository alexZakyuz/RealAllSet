//
//  ContentView.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    let currentDate = Date()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(Color("vanilla"))
                    .ignoresSafeArea()
                
                //hello+date
                VStack{
                    HStack(alignment: .bottom){
                        Text("Hello, \(name)")
                            .font(.title)
                        Spacer()
                        Text(currentDate, style: .date)
                            .font(.title2)
                    }//HStack
                    .padding(.horizontal, 40)
                    
                //add to-do's +background
                    Spacer()
                //bottom toolbar
                    HStack{
                        NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {Text(
                            "🎓")
                        .font(.largeTitle)
                        }
                        NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {Text(
                            "🗓️")
                        .font(.largeTitle)
                        }
                        NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {Text(
                            "Create Class")
                        .font(.largeTitle)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        
                    }//hstack
                }//VStack
            }//Zstack
        }//navigationstack
    }//body
}//struct

#Preview {
    ContentView()
}
