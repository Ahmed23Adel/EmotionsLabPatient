//
//  MainView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                CustomBackground()
            }
        }
    }
}

#Preview {
    MainView()
}
