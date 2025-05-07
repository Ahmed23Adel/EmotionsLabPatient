import SwiftUI

struct ImagesSessionGameView: View {
    @Environment(\.dismiss) var dismiss
    var currentSession: ImagesSession
    @StateObject var viewModel = ImagesSessionGameViewModel()
    var onSessionFinished: () -> Void
    
    // Add new state variables
    @State private var showExitAlert = false
    @State private var selectedExitReason: ExitReason?
    
    // Enum for exit reasons
    enum ExitReason: String, CaseIterable, Identifiable {
        case tired = "I'm tired"
        case tooHard = "This is too hard"
        case other = "Other reason"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        ZStack {
            Color(red: 25/255, green: 166/255, blue: 220/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with home button
                HStack {
                    Spacer()
                    Button(action: {
                        showExitAlert = true
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                Spacer()
                
                if viewModel.isUploadingResults {
                    ProgressView("Please wait...")
                        .foregroundColor(.white)
                } else if viewModel.isShowCoins {
                    StackedCoinsView()
                } else {
                    VStack {
                        MultipleImagesView(emotionsImages: $viewModel.emotionsImages, selectCurrentImageParentFunc: viewModel.imageSelect)
                        MultiplieImageNamesView(emotionNames: $viewModel.emotionNames, selectCurrentNameParentFunc: viewModel.nameSelect)
                    }
                }
                
                Spacer()
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
    
    // Function to handle the exit logic
    private func handleExit(reason: String) {
        print("User exited because: \(reason)")
        dismiss()
    }
}

// Preview
#Preview {
    ImagesSessionGameView(currentSession: ImagesSession(sessionId: UUID(), status: .scheduled), onSessionFinished: {
        
    })
}
