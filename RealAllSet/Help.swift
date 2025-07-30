//
//  Help.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Help: View {
    var body: some View {
        //NavigationStack{
            ZStack{
                Color("vanilla")
                    .ignoresSafeArea()
                VStack {
                    Text("Guides and Tips")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color("lightgreen")
                        )
                        .cornerRadius(19)
                        .padding()
                    Spacer()
                }
                HStack {
                    VStack{
                        
                        Text("Organize")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .background(Color("beigebrown")
                            )
                        
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    
                }
                    
                        
            }
            
            
        //}


        
        
        
    }//body
}//struct

#Preview {
    Help()
}
