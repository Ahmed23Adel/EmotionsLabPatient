//
//  PreGameVideos.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 19/04/2025.
//

import Foundation
struct PreGameVideos{
    private var videosLinks: [String] = []
    
    
    init() {
        initVideosLinks()
    }
    
    mutating private func initVideosLinks(){
        videosLinks.append("https://www.youtube.com/watch?v=64vNirtN1Cc")
        videosLinks.append("https://www.youtube.com/watch?v=qrF4Mydq52k&pp=0gcJCX4JAYcqIYzv")
        videosLinks.append("https://www.youtube.com/watch?v=we1bAwTc9Yw&pp=ygUiZW1vdGlvbnMgaWRlbnRpZmljYXRpb24gZm9yIGF1dGlzbQ%3D%3D")
        videosLinks.append("https://www.youtube.com/watch?v=T4Iq_qaJirs&pp=ygUiZW1vdGlvbnMgaWRlbnRpZmljYXRpb24gZm9yIGF1dGlzbQ%3D%3D")
        
    }
    
    func getCurrentVideoLink() -> String{
        return getRandomVideoLink()
    }
    
    private func getRandomVideoLink() -> String{
        videosLinks.randomElement() ?? "https://www.youtube.com/watch?v=64vNirtN1Cc"
    }
}
