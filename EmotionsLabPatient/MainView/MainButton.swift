//
//  MainButton.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/05/2025.
//

import SwiftUI
// MARK: MainButton
struct MainButton: View {
    var fnAction: () -> Void
    var imgName: String
    var text: String
    var body: some View {
        Button{
            fnAction()
        } label: {
            VStack{
                Image(imgName)
                    .resizable()
                    .frame(width: 130, height: 130)
                    .padding(30)
                HeaderText(text: text)
            }
            .background(.ultraThinMaterial)
            .cornerRadius(25)
            .padding(25)
            
        }
    }
}
// MARK: bottomRightMainButton
struct bottomRightMainButton: View{
    var fnAction: () -> Void
    var imgName: String
    var text: String
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                MainButton(fnAction: fnAction, imgName: imgName, text: text)
                Spacer()
            }
        }
    }
}
// MARK: bottomLeftMainButton
struct bottomLeftMainButton: View{
    var fnAction: () -> Void
    var imgName: String
    var text: String
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                MainButton(fnAction: fnAction, imgName: imgName, text: text)
                
            }
        }
    }
}

#Preview {
    bottomLeftMainButton(fnAction: {}, imgName: "cart", text: "Cart")
}
