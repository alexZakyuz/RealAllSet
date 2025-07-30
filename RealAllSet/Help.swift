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
                    //Spacer()
                    
                    VStack {
                        
                       // VStack{
                            
                            
                            VStack {
                                Text("Organizing")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    //.padding(.top)     // smaller top padding
                                    .padding(.bottom, 100.0)   // tighter space below

                                
                                
                                VStack(alignment: .leading) {
                                    Text("• Choose your area of focus")
                                    Text("• Use a to-do list")
                                    Text("• Set goals")
                                    Text("• Clean up physical clutter")
                                    Text("• Maintain a calendar")
                                }
                                .font(.callout)
                                .fontWeight(.bold)
                                //.padding(.bottom)
                            }
                            //.frame(maxWidth: .infinity) // ← makes it expand
                            .frame(width: 340, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/)
                            .padding(.horizontal)       // ← adds space on both sides
                            .background(Color("beigebrown"))
                            .cornerRadius(19)
                            
                            //.padding(.leading, 50.0)
                            //Spacer()
                            
                            
                            
                            VStack {
                                
                                VStack {
                                    Text("Unwind")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text("• Try to get enough sleep")
                                        Text("• Pick a person you trust")
                                        Text("• Establish small rituals")
                                        Text("• Find a physical activity")
                                        Text("• Recognize when you are stressed")
                                    }
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                }
                                //.frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .frame(width: /*@START_MENU_TOKEN@*/370.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/)
                                .background(Color("beigebrown"))
                                .cornerRadius(19)
                                
                                //.padding(.trailing, 50.0)
                                
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
                            //Spacer()
                            
                            
                        }//dodohe
                        
                        .padding()
                        
                        
                        //}
                        
                        
                        
                        
                    }//scrollview
                    .ignoresSafeArea()
                }//body
            }//struct
        }
    }

#Preview {
    Help()
}
