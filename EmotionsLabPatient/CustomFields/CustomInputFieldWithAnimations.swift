//
//  CustomInputFieldWithAnimations.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 16/04/2025.
//

import SwiftUI

struct CustomInputFieldWithAnimations<Content: View>: View {
    var placeholder: String
    var text: Binding<String>
    @State var animationComplete = false
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // String that drops from the top
                Image("string")
                    .resizable()
                    .frame(width: 30,
                           height: animationComplete ? geometry.size.height * 0.6 : 0)
                    .position(
                        x: geometry.size.width * 0.5,
                        y: animationComplete ? geometry.size.height * 0.25 : 0
                    )
                
                // Custom input field exactly in the middle of screen
                VStack{
                    
                    
                    CustomInputField(placeholder: placeholder, text: text)
                    content()
                    
                }
                .position(
                    x: geometry.size.width * 0.5,
                    y: animationComplete ? geometry.size.height * 0.5 : 0
                )
                
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    animationComplete = true
                }
            }
        }
    }
}


#Preview {
    @State var tmp = ""
    CustomInputFieldWithAnimations(placeholder: "tmp", text: $tmp){
        Text("")
    }
}
