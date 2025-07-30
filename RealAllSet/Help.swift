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
                        
                        
                        Text("Organizing")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                        
                        VStack(alignment: .leading) {

                            Text("• Choose your area of focus")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Use a to-do list")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Set goals")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Clean up physical clutter")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Maintain a calender")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            
                            
                        }
                      //  .padding()
                        
                        Spacer()
                    }
                    .frame(width: 180, height: 500)
                    .background(Color("beigebrown"))
                    .cornerRadius(19)
                    .padding(.leading, 50.0)
                    Spacer()
                    
                    
                    
                    VStack {
                        
                        Text("Unwind")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            Text("• Try to get enough sleep")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Pick a person you trust")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Establish small rituals")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Find a physical activity")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            Text("• Recgonize when you are stressed")
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding()
                            
                            
                        }
                        //.padding()
                        
                        Spacer()
                    }
                    .frame(width: 180, height: 500)

                    .background(Color("beigebrown"))
                    .cornerRadius(19)
                    .padding(.trailing, 50.0)
                    
                }//hsyack
                
                Spacer()
                
                VStack {
                    Text ("Sources")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("vanilla"))
                        .multilineTextAlignment(.center)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    VStack (alignment: .leading){
                        
                        Text("placeholder")
                            .foregroundColor(Color("vanilla"))
                    }
                 
                    
                    
                    
                    
                        
                }
                .frame(width: 400, height: 150)
                .background(Color("darkgreen"))
                .cornerRadius(19)
                .padding()
                Spacer()
                    
                    
            }//dodohe
            .padding()
            
            
            //}
            
            
            
            
            
        }//body
    }//struct
}
#Preview {
    Help()
}
