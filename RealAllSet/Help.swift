//
//  Help.swift
//  RealAllSet
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Help: View {
    var body: some View {
        ZStack{
            Color("vanilla")
                .ignoresSafeArea()
            VStack {
                Text("Guides and Tips")
                    .background(Rectangle() .foregroundColor(.white))
                
            }
        
        }
    }//body
}//struct

#Preview {
    Help()
}
