//
//  SingleImageName.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/04/2025.
//

import Foundation

class SingleImageName: VibratingData, Identifiable, Equatable {
    var id = UUID()
    @Published var emotionName: String
    @Published var isSelected: Bool = false
    @Published var isHide: Bool = false
    @Published var isAbleToSelect = true
    init(emotionName: String) {
        self.emotionName = emotionName
    }
    
    static func == (lhs: SingleImageName, rhs: SingleImageName) -> Bool {
        lhs.id == rhs.id
    }
    
    static func != (lhs: SingleImageName, rhs: SingleImageName) -> Bool {
        !(lhs == rhs)
    }
}
