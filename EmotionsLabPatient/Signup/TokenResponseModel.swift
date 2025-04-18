//
//  TokenResponseModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 16/04/2025.
//

import Foundation

struct TokenRsponseModel: Decodable {
    var accesToken: String
    var refreshToken: String
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accesToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
    
  
}
