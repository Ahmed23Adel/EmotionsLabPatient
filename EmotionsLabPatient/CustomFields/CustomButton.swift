//
//  CustomButton.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/05/2025.
//

import SwiftUI

struct CustomButtonStyle: View {
    var text: String
    var height: CGFloat = 80

    var body: some View {
        Text(text)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
            .frame(minWidth: height, minHeight: height)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.green)

                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(
                            lineWidth: 6
                        )
                        .foregroundColor(.white.opacity(0.4))
                }
            )
            .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}


struct CustomButton: View {
    var text: String
    var action: () -> Void
    var height: CGFloat = 80

    var body: some View {
        Button(action: action) {
            CustomButtonStyle(text: text, height: height)
        }
    }
}

#Preview {
    CustomButton(text: "start", action: {})
}
