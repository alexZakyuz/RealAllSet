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
            ZStack {
                Color("vanilla")
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    
                    Text("Guides and Tips")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                        .background(Color("beigebrown"))
                        .cornerRadius(19)
                        .foregroundColor(.white)
                    
                    VStack(spacing: 16) {
                        // Organizing Box
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Organizing")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("• Choose your area of focus")
                                Text("• Use a to-do list")
                                Text("• Set goals")
                                Text("• Clean up physical clutter")
                                Text("• Maintain a calendar to keep track")
                            }
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .background(Color("lightgreen"))
                        .cornerRadius(19)
                        .frame(maxWidth: .infinity)
                        
                        // Unwind Box
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Unwind")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 8) {
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
                        .padding(.vertical)
                        .background(Color("lightgreen"))
                        .cornerRadius(19)
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Sources Box
                    VStack(spacing: 12) {
                        Text("Sources")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("vanilla"))
                        
                        Link("How to be more organized", destination: URL(string:"https://www.verywellmind.com/how-to-be-more-organized-6541406")!)
                            .foregroundColor(Color("vanilla"))
                        Link("8 ways to lower stress in highschool", destination: URL(string:"https://jedfoundation.org/resource/8-ways-to-lower-stress-in-high-school/")!)
                            .foregroundColor(Color("vanilla"))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    .background(Color("darkgreen"))
                    .cornerRadius(19)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Help()
}
