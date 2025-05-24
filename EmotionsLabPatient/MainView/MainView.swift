//
//  MainView.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var imageScale: CGFloat = 0.1
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                CustomBackground()
                    
                // MARK: Extra buttons
                bottomRightMainButton(fnAction: viewModel.goToBuyAvatarSheet, imgName: "cart", text: "Cart")
                bottomLeftMainButton(fnAction: viewModel.goToSettingsSheet, imgName: "settings", text: "Settings")
                VStack{
                    // MARK: Time period sentence
                    HStack{
                        if viewModel.isTimePeriodLoading{
                            ProgressView("")
                        } else{
                            Text("You have")
                                .font(.title)
                                .foregroundColor(Color(red: 35/255, green: 75/255, blue: 98/255))
                            if viewModel.isActiveTimePeriod{
                                HeaderText(text: "active", isBold: true)
                                
                            } else{
                                HeaderText(text: "no active", isBold: true)
                            }
                           
                            HeaderText(text: " time period")
                            
                        }
                        Image("alex")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .scaleEffect(imageScale)
                            .onAppear{
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)){
                                    imageScale = 1.0
                                }
                            }
                        
                        
                    }
                    // MARK: Today
                    HeaderText(text: "Today")
                   
                    // MARK: Number of sessions
                    HStack{
                        HeaderText(text: "You have ")
                        if viewModel.isLoadingSessions{
                            ProgressView("")
                        } else {
                            if viewModel.isActiveSessionToday{
                                CounterView(finalValue: viewModel.numTodaySessions)
                            } else{
                                HeaderText(text: "No", isBold: true)
                                Text("No")
                                    .foregroundColor(Color(red: 35/255, green: 75/255, blue: 98/255))
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        HeaderText(text: " sessions to do")
                    }
                    
                    // MARK: Buttons to new game
                    VStack {
                        if !viewModel.todayActiveSessions.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 10) {
                                    Spacer()
                                    ForEach(viewModel.todayActiveSessions.filter({ $0.status == .scheduled }), id: \.id) { session in
                                        if let imageSession = session as? ImagesSession{
                                            if viewModel.isNavigateToTutorial{
                                                NavigationLink(destination: ImageSessionGameTutorialView (currentSession: imageSession, onSessionFinished: { viewModel.refreshSessionsTutorial() })) {
                                                    CustomButtonStyle(text: "Start")
                                                }
                                            } else {
                                                NavigationLink(destination: ImagesSessionGameView(currentSession: imageSession, onSessionFinished: { viewModel.refreshSessions() })) {
                                                    CustomButtonStyle(text: "Start")
                                                }
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity) // This centers the content within the ScrollView
                            }
                        }
                    }
                    .frame(maxWidth: 270) // Keep the original constraint to maintain blur section width

                }
                .padding(50)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.ultraThinMaterial)
                )
                
                
            }
        }
        .sheet(isPresented: $viewModel.isShowBuyAvatarSheet){
            BuyAvatarView()
        }
        .sheet(isPresented: $viewModel.isShowSettingsSheet){
            SettingsSheet(onLogout: viewModel.onLogout)
        }
        .navigationDestination(isPresented: $viewModel.isNavigateToSignUpView){
            SignUpView()
        }
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled()
    }
    
    
}
// MARK: - Counter View for showing number of emotions
struct CounterView: View {
    let finalValue: Int
    @State private var animationCount = 0
    @State private var animationOffset: CGFloat = 50
    @State private var animationOpacity: Double = 0
    
    var body: some View {
        Text("\(animationCount)")
            .font(.title2)
            .bold()
            .foregroundColor(Color(red: 39/255, green: 84/255, blue: 138/255))
            .offset(y: animationOffset)
            .opacity(animationOpacity)
            .onAppear {
                startCountingAnimation()
            }
    }
    
    private func startCountingAnimation() {
        // Reset values
        animationCount = 0
        animationOffset = 50
        animationOpacity = 0
        
        // Show the first number with animation
        withAnimation(.easeOut(duration: 0.3)) {
            animationOffset = 0
            animationOpacity = 1
        }
        
        // Animate through each number
        if finalValue > 0 {
            let animationDuration = min(1.5, Double(finalValue) * 0.1)
            let delayBetweenNumbers = animationDuration / Double(finalValue)
            
            for i in 1...finalValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * delayBetweenNumbers) {
                    // Slide current number up and fade out
                    withAnimation(.easeOut(duration: 0.2)) {
                        animationOffset = -50
                        animationOpacity = 0
                    }
                    
                    // Slight delay before showing next number
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        // Update to new number but position it below
                        animationCount = i
                        animationOffset = 50
                        
                        // Slide new number up and fade in
                        withAnimation(.easeOut(duration: 0.2)) {
                            animationOffset = 0
                            animationOpacity = 1
                        }
                    }
                }
            }
        }
            
    }
}

#Preview {
    MainView()
}
