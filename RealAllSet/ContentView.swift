//
//  ContentView.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let currentDate = Date()
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    let userName: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("vanilla")
                    .ignoresSafeArea()
                
                //hello+date
                VStack{
                    HStack(alignment: .bottom){
                        Text("Hello, \(userName)!")
                        //add variable
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text(currentDate, style: .date)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }//HStack
                    .padding([.top, .leading, .trailing], 30)
                    
                //add to-do's +background
                    Spacer()
                //bottom toolbar
                    HStack{
                        NavigationLink {ClassHome()} label: {Text(
                            "🎓 Class List")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .background(Rectangle()
                            .frame(width: 150, height: 50.0)
                            .foregroundColor(Color("lightgreen"))
                            .cornerRadius(5))
                        }
                        
                        Spacer()
                        
                        NavigationLink{CalendarView()} label: {Text(
                            "🗓️ Calendar")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .background(Rectangle()
                            .frame(width: 150, height: 50.0)
                            .foregroundColor(Color("lightgreen"))
                            .cornerRadius(5))
                        }
                        
                        Spacer()
                        
                        NavigationLink{Help()} label: {Text(
                            "ⓘ")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .background(Rectangle()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(Color("lightgreen"))
                            .cornerRadius(5))
                        }
                    }//hstack
                    .padding(30)
               
                    
                }//VStack
            }//Zstack
        }//navigationstack
    }//body
}//struct

#Preview {
    ContentView(userName: "Test User")
        .modelContainer(for: User.self, inMemory: true)
}
