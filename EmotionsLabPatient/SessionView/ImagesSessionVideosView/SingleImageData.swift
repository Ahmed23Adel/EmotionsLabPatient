//
//  SingleImage.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/04/2025.
//

import Foundation

class SingleImage: VibratingData, Identifiable, Equatable {
    var id = UUID()
    @Published var imageName: String
    @Published var emotionName: String
    @Published var isSelected: Bool = false
    @Published var isHide: Bool = false
    @Published var isAbleToSelect = true
    
    init(imageName: String, emotionName: String) {
        self.imageName = imageName
        self.emotionName = emotionName
    }
    
    static func == (lhs: SingleImage, rhs: SingleImage) -> Bool {
        lhs.id == rhs.id
    }
    
    static func != (lhs: SingleImage, rhs: SingleImage) -> Bool {
        lhs.id != rhs.id
    }
}
