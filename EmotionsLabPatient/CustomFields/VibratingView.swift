//
//  VibratingView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 30/04/2025.
//

import SwiftUI

struct VibratingView<Content: View>: View {
    @Binding var triggerVibration: Bool
    @ObservedObject var vibratingData: VibratingData
    let content: () -> Content
    
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
        content()
            .offset(x: offsetX)
            .onChange(of: triggerVibration){
                if triggerVibration {
                    vibrate()
                }
            }
    }
    
    private func vibrate() {
        let duration = 0.05
        let numVibrations = 5
        
        for i in 0..<numVibrations {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i * 2)) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetX = 5
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(i * 2 + 1)) {
                withAnimation(.easeInOut(duration: duration)) {
                    offsetX = -5
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(numVibrations * 2)) {
            withAnimation(.easeInOut(duration: duration)) {
                offsetX = 0
            }
            triggerVibration = false
        }
        vibratingData.isShowError = false
    }

    
}

#Preview {
    @State var randomBool = true
    
    return VibratingView(triggerVibration: $randomBool, vibratingData: VibratingData()){
        Text("Random text")
    }
}
