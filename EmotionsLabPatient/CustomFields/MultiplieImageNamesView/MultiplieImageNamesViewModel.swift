//
//  MultiplieImageNamesViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/04/2025.
//

import Foundation

class MultiplieImageNamesViewModel: ObservableObject {
    @Published var emotionNames: [String: [SingleImageName]] = [:]

    var shuffledRows: [[SingleImageName]] {
        let emotionArrays: [[SingleImageName]] = Array(emotionNames.values)
        let flatArray: [SingleImageName] = emotionArrays.flatMap { $0 }
        let shuffled: [SingleImageName] = flatArray.shuffled()

        var result: [[SingleImageName]] = []
        for index in stride(from: 0, to: shuffled.count, by: 4) {
            let chunk = Array(shuffled[index..<min(index + 4, shuffled.count)])
            result.append(chunk)
        }

        return result
    }

    func setEmotionNames(emotionNames: [String: [SingleImageName]]) {
        self.emotionNames = emotionNames
    }
}
