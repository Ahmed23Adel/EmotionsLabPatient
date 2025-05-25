import SwiftUI

struct ImagesSessionGameView: View {
    @Environment(\.dismiss) var dismiss
    var currentSession: ImagesSession
    @StateObject var viewModel = ImagesSessionGameViewModel()
    var onSessionFinished: () -> Void
    
    // Add new state variables
    @State private var showExitAlert = false
    @State private var selectedExitReason: ExitReason?
    @State private var isPaused = false
        
    var body: some View {
        ZStack {
            if viewModel.chosenBakcground != "noBackground" {
                Image(viewModel.chosenBakcground)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                // MARK: Header with pause and home buttons
                HStack (spacing: 10) {
                    Spacer()
                    
                    // MARK:  Pause/Resume button
                    Button(action: {
                        
                        isPaused.toggle()
                        if isPaused{
                            viewModel.pauseGame()
                        }
                    }) {
                        pauseResumeButtonImage
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 60)
                    
                    // MARK:  Home/Exit button
                    Button(action: {
                        showExitAlert = true
                    }) {
                        homeButtonImage
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 60)
                    .padding(.trailing, 10)
                }
                
                
                // Content immediately after header (no Spacer here)
                if viewModel.isUploadingResults {
                    ProgressView("Please wait...")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.isShowCoins {
                    StackedCoinsView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        MultipleImagesView(emotionsImages: $viewModel.emotionsImages, selectCurrentImageParentFunc: viewModel.imageSelect)
                        MultiplieImageNamesView(emotionNames: $viewModel.emotionNames, selectCurrentNameParentFunc: viewModel.nameSelect)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .disabled(isPaused) // Disable interaction when paused
                }
            }
            if viewModel.showFeedbackMessage {
                VStack {
                    Spacer()
                    HeaderText(text: viewModel.feedbackMessage)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .offset(y: -50).combined(with: .opacity)))
                        .padding(.bottom, 120)
                }
                .animation(.easeInOut(duration: 0.4), value: viewModel.showFeedbackMessage)
                .onTapGesture {
                    viewModel.showFeedbackMessage = false
                }
            }

            
            // MARK:  Pause overlay
            if isPaused {
                pauseOverlay
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled()
        .onAppear {
            viewModel.setCurrentSession(currentSession)
            viewModel.setFuncOnSessionFinshed(onSessionFinished: onSessionFinished)
        }
        .onChange(of: viewModel.isGameFinished) {
            if viewModel.isGameFinished {
                dismiss()
            }
        }
        .alert("Why do you want to leave?", isPresented: $showExitAlert) {
            ForEach(ExitReason.allCases) { reason in
                Button(reason.rawValue) {
                    handleExit(reason: reason.rawValue)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please select a reason")
        }
    }
    
    private var homeButtonImage: some View {
        Image("homeIconNoBackground")
            .resizable()
            .frame(width: 50, height: 50)
    }
    
    private var pauseResumeButtonImage: some View {
         // playNullImage will make the image empty
        Image(isPaused ? "playNullImage" : "pause")
            .resizable()
            .frame(width: 50, height: 50)
    }
    
    private var pauseOverlay: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Button(action: {
                    isPaused = false
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 120, height: 120)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        Image(systemName: "play.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color(red: 35/255, green: 75/255, blue: 98/255))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("Game Paused")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Tap the play button to continue")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))

                
            }
        }
    }
    
    private func handleExit(reason: String) {
        Task {
            await viewModel.uploadExitReason(exitReason: reason)
        }
        
        dismiss()
    }
}

#Preview {
    ImagesSessionGameView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled), onSessionFinished: {
        
    })
}
