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
                    
                    HStack {
                        VStack{
                            
                            Text("Being Organized")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .leading) {
                                Text("• Choose your area of focus")
                                Text("• Use a to-do list")
                                Text("• Set goals")
                                Text("• Clean up physical clutter")
                                Text("• Maintain a calender")


                            }

                            //Spacer()
                        }
                        .background(Color("beigebrown"))
                        .cornerRadius(19)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
            
                        
                        VStack{
                            
                            Text("Reduce Stress")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            //Spacer()
                        }
                        .background(Color("beigebrown"))
                        .cornerRadius(19)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                    }//hsyack
                    
                    Text ("Sources")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                        
                        
                        .background(Color("darkgreen"))
                        .cornerRadius(19)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Spacer()
                    
                
                }//vstack
            }
            
            
        //}


        
        
        
    }//body
}//struct

#Preview {
    Help()
}
