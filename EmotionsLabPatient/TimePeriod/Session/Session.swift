//
//  Session.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation

protocol Session: AnyObject, Identifiable, ObservableObject {
    var sessionId: UUID { get }
    var status: SessionStatus { get set }
    func setStateFinishedAndUpload() async
}
