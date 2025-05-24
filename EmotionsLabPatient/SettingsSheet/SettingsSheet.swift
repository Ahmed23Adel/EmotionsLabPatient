//
//  SettingsSheet.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 24/05/2025.
//

import SwiftUI

struct SettingsSheet: View {
    @StateObject private var viewModel = SettingsSheetViewModel()
    @Environment(\.dismiss) var dismiss
    let onLogout: () -> Void
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 138/255, green: 204/255, blue: 213/255)
                VStack{
                    
                    HStack {
                        HeaderText(text: "Choose background")
                            .padding(25)
                        Spacer()
                    }
                    ScrollView(.horizontal){
                        
                        
                        HStack {
                            ForEach(viewModel.allBackgrounds, id: \.self) { img in
                                if img != viewModel.noBackgroundName {
                                    ZStack {
                                        if img == viewModel.chosenBakcground {
                                            Rectangle()
                                                .fill(Color.green)
                                                .opacity(0.7)
                                                .frame(width: 210, height: 160)
                                                .cornerRadius(25)
                                                .transition(.scale.combined(with: .opacity))
                                        }
                                        Image(img)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 200, height: 150)
                                            .cornerRadius(25)
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            viewModel.chosenBakcground = img
                                        }
                                    }
                                } else {
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 200, height: 150)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                viewModel.chosenBakcground = img
                                            }
                                        }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(20)
                
                Button(role: .destructive){
                    
                    viewModel.logout()
                    dismiss()
                    onLogout()
                    
                } label: {
                    Label("Log out", systemImage: "arrow.backward.circle")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationDestination(isPresented: $viewModel.isNavigateToSignUp){
                SignUpView()
            }
            
        }
        
    }
}

#Preview {
    SettingsSheet(onLogout: {})
}
