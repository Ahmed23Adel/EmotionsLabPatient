//
//  SingleImageNameWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageNameWithAnimation: View {
    @State var scaleValue = 0.1
    var text: String
    var body: some View {
        SingleImageName(text: text)
            .scaleEffect(scaleValue)
            .onAppear{
                withAnimation(.bouncy(duration: 1)){
                    scaleValue = 1
                }
            }
            
    }
}

#Preview {
    SingleImageNameWithAnimation(text: "Happy")
}
