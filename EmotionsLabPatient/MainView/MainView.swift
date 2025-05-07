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
                VStack{
                    Spacer()
                    HStack{
                        Button{
                            viewModel.goToBuyAvatarSheet()
                        } label: {
                            VStack{
                                Image("cart")
                                    .resizable()
                                    .frame(width: 130, height: 130)
                                    .padding(30)
                                Text("Cart")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            .background(.ultraThinMaterial)
                            .cornerRadius(25)
                            .padding(25)
                            
                        }
                        
                        Spacer()
                    }
                }
                VStack{
                    HStack{
                        if viewModel.isTimePeriodLoading{
                            ProgressView("")
                        } else{
                            Text("You have")
                                .font(.title)
                                .foregroundColor(Color(red: 39/255, green: 84/255, blue: 138/255))
                            
                            if viewModel.isActiveTimePeriod{
                                Text("active")
                                    .font(.title)
                                    .foregroundColor(Color.brown)
                            } else{
                                Text("no active")
                                    .font(.title)
                                    .foregroundColor(Color.red)
                            }
                           
                            
                            Text(" time period")
                                .font(.title)
                                .foregroundColor(Color(red: 39/255, green: 84/255, blue: 138/255))
                            
                            
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
                    Text("Today")
                        .font(.title2)
                        .foregroundColor(Color(red: 39/255, green: 84/255, blue: 138/255))
                    HStack{
                        Text("You have ")
                            .foregroundColor(Color(red: 39/255, green: 84/255, blue: 138/255))
                        if viewModel.isLoadingSessions{
                            ProgressView("")
                        } else {
                            if viewModel.isActiveSessionToday{
                                CounterView(finalValue: viewModel.numTodaySessions)
                            } else{
                                Text("No")
                                    .foregroundColor(Color.red)
                            }
                        }
                        
                        
                        Text(" sessions to do")
                            .foregroundColor(Color(red: 39/255, green: 84/255, blue: 138/255))
                    }
                    
                    // Replace your current List with this
                    VStack {
                        if !viewModel.todayActiveSessions.isEmpty {
                            ScrollView {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.todayActiveSessions.filter({ $0.status == .scheduled }), id: \.id) { session in
                                        if let imageSession = session as? ImagesSession{
                                            NavigationLink(destination: ImagesSessionGameView(currentSession: imageSession, onSessionFinished: {  viewModel.refreshSessions() })) {
                                                CustomButtonStyle(text: "Start")
                                            }
                                        }
                                    }
                                }
                                .frame(maxWidth: 230) // Control the width here
                            }
                            .frame(height: min(CGFloat(viewModel.todayActiveSessions.count) * 60, 180))
                        } else {
                            Text("No sessions scheduled for today")
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    }
                    .frame(maxWidth: 230) // This centers the content
                    
                    
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
    }
}
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
