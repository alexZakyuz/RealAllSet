//
//  ContentView.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct ContentView: View {
    @State var name = ""
    let currentDate = Date()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("vanilla")
                    .ignoresSafeArea()
                
                //hello+date
                VStack{
                    HStack(alignment: .bottom){
                        Text("Hello, \(name)")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text(currentDate, style: .date)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }//HStack
                    .padding([.top, .leading, .trailing], 40)
                    
                //add to-do's +background
                    Spacer()
                //bottom toolbar
                    HStack{
                        NavigationLink { ClassHome()} label: {Text(
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
                        
                        NavigationLink{ /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/} label: {Text(
                            "🗓️ Calendar")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .background(Rectangle()
                            .frame(width: 150, height: 50.0)
                            .foregroundColor(Color("lightgreen"))
                            .cornerRadius(5))
                        }
                    }//hstack
                    .padding(50)
                    
                }//VStack
            }//Zstack
        }//navigationstack
    }//body
}//struct

#Preview {
    ContentView()
}
