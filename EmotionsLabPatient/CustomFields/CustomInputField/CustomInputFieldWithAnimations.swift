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
    @State private var animate = false
    let content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Falling string
                Image("string")
                    .resizable()
                    .frame(width: 30, height: geometry.size.height * 0.6)
                    .position(
                        x: geometry.size.width / 2,
                        y: animate
                            ? geometry.size.height * 0.25
                            : -geometry.size.height * 0.3 // off-screen initially
                    )
                    .animation(.easeOut(duration: 1), value: animate)

                // Falling input field
                VStack {
                    CustomInputField(placeholder: placeholder, text: text)
                    content()
                }
                .frame(width: geometry.size.width * 0.8)
                .position(
                    x: geometry.size.width / 2,
                    y: animate
                        ? geometry.size.height * 0.5
                        : -geometry.size.height // off-screen initially
                )
                .animation(.easeOut(duration: 1.2), value: animate)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                // Trigger the fall after a short delay if desired
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    animate = true
                }
            }
        }
    }
}


#Preview {
    @Previewable @State var tmp = ""
    CustomInputFieldWithAnimations(placeholder: "tmp", text: $tmp){
        Text("")
    }
}
