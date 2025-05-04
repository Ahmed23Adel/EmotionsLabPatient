//
//  SingleAvatar.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 04/05/2025.
//

import Foundation

class SingleAvatar: ObservableObject, Identifiable{
    let id = UUID()
    let avatarId: String
    let name: String
    let imageUrl: String
    let price: Int
    @Published var isPurchased: Bool
    
    init(avatarId: String, name: String, imageUrl: String, price: Int, isPurchased: Bool) {
        self.avatarId = avatarId
        self.name = name
        self.imageUrl = imageUrl
        self.price = price
        self.isPurchased = isPurchased
    }
}
