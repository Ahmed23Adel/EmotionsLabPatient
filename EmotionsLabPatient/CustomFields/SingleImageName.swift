//
//  SingleImageName.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageName: View {
    var text: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 40)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 255/255, green: 0/255, blue: 127/255), // light orange
                            Color(red: 255/255, green: 110/255, blue: 199/255) //dark orange
                            
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    
                )
                .frame(width: 160, height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.white.opacity(0.7),
                                        Color.white.opacity(0.0),
                                    ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 255/255, green: 219/255, blue: 50/255), // light orange
                            Color(red: 255/255, green: 140/255, blue: 0/255) //dark orange
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    
                )
                .frame(width: 130, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.white.opacity(0.1),
                                        Color.white.opacity(0.0),
                                    ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            CustomText(text: text)
                
            
        }
    }
}


struct CustomText: View {
    var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .foregroundColor(Color(red: 24/255, green: 59/255, blue: 78/255))
                .font(.system(size: 25))
                
        }
    }
}



#Preview {
    SingleImageName(text: "Happy")
}
