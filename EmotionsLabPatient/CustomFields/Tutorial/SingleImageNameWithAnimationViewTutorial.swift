
//
//  SingleImageNameWithAnimation.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI

struct SingleImageNameWithAnimationViewTutorial: View {
    @State var scaleValue = 0.1
    @State private var offsetX: CGFloat = 0 // For vibration effect
    @ObservedObject var currentSingleName: SingleImageName
    var selectCurrentNameParentFunc: (SingleImageName) -> Void
    
    var body: some View {
        ZStack {
            VibratingView(triggerVibration: $currentSingleName.isShowError, vibratingData: currentSingleName){
                SingleImageNameViewTutorial(currentSingleName: currentSingleName, selectCurrentNameParentFunc: selectCurrentNameParentFunc)
                    .scaleEffect(scaleValue)
            }
            .onAppear{
                withAnimation(.easeIn(duration: 0.5)) {
                    scaleValue = 1
                }
            }
            .onChange(of: currentSingleName.isHide) {
                withAnimation(.easeOut(duration: 0.2)) {
                    scaleValue = 0
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var currentSingleName = SingleImageName(emotionName: "Happy")
    let dummyFunc: (SingleImageName) -> Void = { image in
        print("Dummy function called with: \(image)")
    }
    SingleImageNameWithAnimationViewTutorial(currentSingleName: currentSingleName, selectCurrentNameParentFunc: dummyFunc)
}
