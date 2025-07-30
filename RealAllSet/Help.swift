//
//  Help.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Help: View {
    var body: some View {
        ZStack {
            Color("vanilla")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {   // less vertical space
                    
                    Text("Guides and Tips")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(12)       // less padding
                        .background(Color("beigebrown"))
                        .cornerRadius(19)
                        .padding(.top, 10)
                    
                    // Organizing Section
                    VStack(spacing: 10) {   // less spacing
                        Text("Organizing")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .background(Color("beigebrown"))
                            .cornerRadius(19)
                        
                        VStack(spacing: 6) {    // less spacing
                            Text("• Choose your area of focus")
                            Text("• Use a to-do list")
                            Text("• Set goals")
                            Text("• Clean up physical clutter")
                            Text("• Maintain a calendar")
                        }
                        .font(.callout)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background(Color("lightgreen"))
                        .cornerRadius(19)
                    }
                    .frame(maxWidth: 350)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    // Unwind Section
                    VStack(spacing: 10) {
                        Text("Unwind")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .background(Color("beigebrown"))
                            .cornerRadius(19)
                        
                        VStack(spacing: 6) {
                            Text("• Try to get enough sleep")
                            Text("• Pick a person you trust")
                            Text("• Establish small rituals")
                            Text("• Find a physical activity")
                            Text("• Recognize when you are stressed")
                        }
                        .font(.callout)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background(Color("lightgreen"))
                        .cornerRadius(19)
                    }
                    .frame(maxWidth: 350)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    // Sources Section
                    VStack(spacing: 10) {
                        Text("Sources")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("vanilla"))
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                        
                        Link("How to be more organized", destination: URL(string:"https://www.verywellmind.com/how-to-be-more-organized-6541406")!)
                            .foregroundColor(Color("vanilla"))
                            .underline()
                        
                        Link("8 ways to lower stress in highschool", destination: URL(string:"https://jedfoundation.org/resource/8-ways-to-lower-stress-in-high-school/")!)
                            .foregroundColor(Color("vanilla"))
                            .underline()
                    }
                    .padding(12)
                    .background(Color("darkgreen"))
                    .cornerRadius(19)
                    .frame(maxWidth: 350)
                    .layoutPriority(1)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    Help()
}
