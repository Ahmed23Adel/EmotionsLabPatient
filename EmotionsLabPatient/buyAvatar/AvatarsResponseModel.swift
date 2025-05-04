//
//  AvatarsResponseModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 04/05/2025.
//

import Foundation

struct Avatar: Codable {
    let avatarId: String
    let name: String
    let imageUrl: String
    let price: Int
    let isPurchased: Bool
    let isSelected: Bool
    let purchasedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarId = "avatar_id"
        case name
        case imageUrl = "image_url"
        case price
        case isPurchased = "is_purchased"
        case isSelected = "is_selected"
        case purchasedAt = "purchased_at"
    }
    
    func extractSingleAvatar() -> SingleAvatar{
        SingleAvatar(avatarId: avatarId,
                     name: name,
                     imageUrl: imageUrl,
                     price: price,
                     isPurchased: isPurchased
        )
    }
}

struct AllAvatarsAndCoinsResponseModel: Codable {
    let patientId: String
    let coins: Int
    let avatars: [Avatar]
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case coins
        case avatars
    }
    
    func extractAllAvatars() -> [SingleAvatar]{
        var allAvatars: [SingleAvatar] = []
        for avatar in avatars {
            allAvatars.append(avatar.extractSingleAvatar())
        }
        return allAvatars
    }
}
