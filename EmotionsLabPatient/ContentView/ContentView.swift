//
//  ContentView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 10/04/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        Group{
            if viewModel.isChecking{
                ProgressView("Checking")
            }else{
                if viewModel.userNeedsToSignUp{
                    SignUpView()
                } else{
                    MainView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
