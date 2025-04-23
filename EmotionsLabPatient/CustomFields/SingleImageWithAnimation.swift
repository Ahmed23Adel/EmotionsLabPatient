//
//  SingleImageWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageWithAnimation: View {
    @State var scaleValue = 0.1
    var imgName: String
    @Binding var isSelected: Bool
    var body: some View {
        SingleImage(imgName: imgName, isSelected: $isSelected)
            .scaleEffect(scaleValue)
            .onAppear{
                withAnimation(.bouncy(duration: 1)){
                    scaleValue = 1
                }
            }
            
    }
}

#Preview {
    @State var isSelected = false
    SingleImageWithAnimation(imgName: "happy1", isSelected: $isSelected)
}
