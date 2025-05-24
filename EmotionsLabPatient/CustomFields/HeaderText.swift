//
//  HeaderText.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/05/2025.
//

import SwiftUI

struct HeaderText: View {
    var text: String
    var isBold: Bool = false
    var body: some View {
        
        Text(text)
            .font(.title)
            .foregroundColor(Color(red: 35/255, green: 75/255, blue: 98/255))
            .fontWeight(isBold ? .bold : .regular)
    }
}

#Preview {
    HeaderText(text: "You have")
}
