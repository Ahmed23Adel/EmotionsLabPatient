//
//  SingleImageNameWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageNameWithAnimationView: View {
    @State var scaleValue = 0.1
    @ObservedObject var currentSingleName: SingleImageName
    var selectCurrentNameParentFunc: (SingleImageName) -> Void
    
    var body: some View {
        if !currentSingleName.isHide {
            SingleImageNameView(currentSingleName: currentSingleName, selectCurrentNameParentFunc: selectCurrentNameParentFunc)
                .scaleEffect(scaleValue)
                .onAppear {
                    withAnimation(.bouncy(duration: 1)) {
                        scaleValue = 1
                    }
                }
                .transition(.scale.combined(with: .opacity))
        } else {
            // Return an empty view when hidden
            Color.clear
                .frame(width: 0, height: 0)
        }
    }
}

#Preview {
    @State var currentSingleName = SingleImageName(emotionName: "Happy")
    let dummyFunc: (SingleImageName) -> Void = { image in
        print("Dummy function called with: \(image)")
    }
    SingleImageNameWithAnimationView(currentSingleName: currentSingleName, selectCurrentNameParentFunc: dummyFunc)
}
