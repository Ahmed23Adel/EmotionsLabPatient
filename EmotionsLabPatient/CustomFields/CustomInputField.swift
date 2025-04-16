//
//  CustomInputField.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 16/04/2025.
//

import SwiftUI

struct CustomInputField: View {
    var placeholder: String
    var text: Binding<String>
    var body: some View {
        ZStack{
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
                .frame(width: 300, height: 120)
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
                            Color(red: 0.4, green: 0.25, blue: 0.15), // Lighter brown
                            Color(red: 0.35, green: 0.2, blue: 0.1)   // Darker brown
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    
                )
                .frame(width: 270, height: 90)
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
            CustomTextField(text: text, placeholder: placeholder)
                
            
        }
    }
}


struct CustomTextField: View {
    var text: Binding<String>
    var placeholder: String = "Enter text"
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.2))
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            TextField("", text: text)
                .font(.largeTitle)
                .foregroundColor(Color(red: 0.95, green: 0.65, blue: 0.2))
                .fontWeight(.bold)
        }
        .frame(width: 260, height: 80)
    }
}


#Preview {
    @State var tmp = ""
    CustomInputField(placeholder: "tmp", text: $tmp)
}
