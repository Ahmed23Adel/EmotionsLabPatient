//
//  Session.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation

protocol Session: Identifiable {
    var id: UUID { get }
    var status: SessionStatus { get set }
}
