//
//  SingleImageName.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 23/04/2025.
//

import SwiftUI



struct SingleImageNameViewTutorial: View {
    @ObservedObject var currentSingleName: SingleImageName
    @State var selectedColorGradient = [
        Color.green
    ]
    @State var notSelectedColorGradient = [
        Color(red: 255/255, green: 110/255, blue: 199/255)
    ]
    @State var imgWidthBig = 160.0
    @State var imgHeightBig = 70.0
    @State var imgWidthSmall = 150.0
    @State var imgHeightSmall = 60.0
    
    var selectCurrentNameParentFunc: (SingleImageName) -> Void
    @State var isPulsing = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    Color(red: 35/255, green: 75/255, blue: 98/255)
                    
                )
                .frame(width: imgWidthBig, height: imgHeightBig)
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    Color(red: 251/255, green: 247/255, blue: 233/255)
                )
                .frame(width: imgWidthSmall, height: imgHeightSmall)
            CustomText(text: currentSingleName.emotionName.capitalizingFirstLetter())
            if currentSingleName.isTutorialShowIndicator{
               
                Circle()
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 110, height: 110)
                    .scaleEffect(isPulsing ? 1.1 : 1.0)
                    .animation(
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                        value: isPulsing
                    )
                    .onAppear{
                        isPulsing = true
                        
                    }
            }
        }
        .onTapGesture {
            if currentSingleName.isAbleToSelect{
                currentSingleName.isSelected.toggle()
                selectCurrentNameParentFunc(currentSingleName)
                
                
            }
        }
        .onChange(of: currentSingleName.isSelected){
            SelectOrUnselectView()
        }
    }
    
    
    private func selectName(){
        imgWidthBig += 10
        imgHeightBig += 10
        imgWidthSmall += 10
        imgHeightSmall += 10
    }
    private func unSelectName(){
        imgWidthBig -= 10
        imgHeightBig -= 10
        imgWidthSmall -= 10
        imgHeightSmall -= 10
    }
    
    private func SelectOrUnselectView(){
        if currentSingleName.isSelected{
            withAnimation(.easeIn(duration: 0.1)){
                selectName()
            }
        } else{
            withAnimation(.easeIn(duration: 0.1)){
                unSelectName()
            }
        }
        
    }
}





#Preview {
    @Previewable @State var currentSingleName = SingleImageName(emotionName: "Happy")
    let dummyFunc: (SingleImageName) -> Void = { image in
        print("Dummy function called with: \(image)")
    }

    SingleImageNameViewTutorial(currentSingleName: currentSingleName, selectCurrentNameParentFunc: dummyFunc)
}
