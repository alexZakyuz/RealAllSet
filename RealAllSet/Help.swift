//
//  Help.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Help: View {
    var body: some View {
        ScrollView {
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
                    
                    VStack {
                        
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
                            
                            //Spacer()
                        }
                       // .frame(width: 180, height: 500)
                        .background(Color("beigebrown"))
                        .cornerRadius(19)
                        .padding(.leading, 50.0)
                        //Spacer()
                        
                        
                        
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
                            
                            //Spacer()
                        }
                        //.frame(width: 180, height: 500)
                        
                        .background(Color("beigebrown"))
                        .cornerRadius(19)
                        .padding(.trailing, 50.0)
                        
                    }//hsyack
                    
                    //Spacer()
                    
                    VStack {
                        Text ("Sources")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("vanilla"))
                            .multilineTextAlignment(.center)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        
                        Link(destination: URL(string:"https://www.verywellmind.com/how-to-be-more-organized-6541406")!) {
                            Text("How to be more organized")
                            
                        }
                        .foregroundColor(Color("vanilla"))
                        Link(destination: URL(string:"https://jedfoundation.org/resource/8-ways-to-lower-stress-in-high-school/")!) {
                            Text("8 ways to lower stress in highschool")
                            
                        }.foregroundColor(Color("vanilla"))
                        // Text("")
                        
                        
                    }
                    .padding(.horizontal)
                    .frame(width: 370, height: 150)
                    .background(Color("darkgreen"))
                    .cornerRadius(19)
                    //.padding(2)
                    .padding()
                    Spacer()
                    
                    
                }//dodohe
                
                .padding()
                
                
                //}
                
                
                
                
            }//scrollview
            .ignoresSafeArea()
        }//body
    }//struct
}
#Preview {
    Help()
}
