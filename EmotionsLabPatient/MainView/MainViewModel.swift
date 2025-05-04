//
//  MainViewModel.swift
//  EmotionsLabPatient
//
//  Created by ahmed on 15/04/2025.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject{
    @Published var isActiveTimePeriod = false
    @Published var numTodaySessions = 0
    private let apiCaller = ApiCaller()
    private let timePeriod = TimePeriod()
    @Published var isTimePeriodLoading = true
    @Published var isActiveSessionToday = false
    @Published var numScheduleSessionsToday = 0
    @Published var isLoadingSessions = true
    @Published var todayActiveSessions: [any ObservableObject & Session] = []
    @Published var isShowBuyAvatarSheet = false
    
    
    init(){
        Task{
            do {
                
                try await loadActiveTimePeriod()
                try await loadActiveSessions()
                
            } catch TimePeriodError.noTimePeriod {
                showNoActivePeriod()
                showNoActiveSession()
            } catch SessionError.noActiveSessionToday{
                showNoActiveSession()
            }
            
        }
        
    }
    
    
    private func loadActiveTimePeriod() async throws{
        do {
            showPeriodLoading()
            try await timePeriod.loadActiveTimePeriod()
            showActivePeriod()
            
        } catch {
            throw TimePeriodError.noTimePeriod
        }
    }
    
    private func showNoActivePeriod(){
        isTimePeriodLoading = false
        isActiveTimePeriod = false
    }
    
    private func showActivePeriod(){
        isTimePeriodLoading = false
        isActiveTimePeriod = true
    }
    
    private func showPeriodLoading(){
        isTimePeriodLoading = true
    }
    
    private func showNoActiveSession(){
        isLoadingSessions = false
        isActiveSessionToday = false
    }
    private func loadActiveSessions() async throws {
        do {
            let data = try await apiCaller.callApiWithToken(
                endpoint: "sessions/today",
                method: .get,
                token: Patient.shared.authAccess.accessTokenValue,
                params: [
                    "period_id": timePeriod.periodId
                ]
            )
            try parseSessionData(data: data)
        } catch {
            print("API call error: \(error.localizedDescription)")
            throw SessionError.noActiveSessionToday
        }
    }

    private func parseSessionData(data: Data) throws {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(SessionsTodayResponse.self, from: data)
            showResultsSessionToday(response: response)
        } catch {
            throw SessionError.noActiveSessionToday
        }
    }

    private func showResultsSessionToday(response: SessionsTodayResponse) {
        var numTodaySessionsTmp = 0
        for session in response.sessions {
            if session.status == "scheduled" {
                numTodaySessionsTmp += 1
                timePeriod.addSession(session: SessionFactory.generateSession(
                    sessionId: session.sessionID,
                    gameTypeName: session.gameTypeName,
                    status: .scheduled,
                    
                ))
            }
        }
        numTodaySessions = numTodaySessionsTmp
        isActiveSessionToday = true
        isLoadingSessions = false
        loadTodaySessionLocal()
    }
    private func loadTodaySessionLocal(){
        todayActiveSessions = timePeriod.todayActiveSessions
    }
    
    func refreshSessions() {
        todayActiveSessions = timePeriod.todayActiveSessions
        numTodaySessions -= 1
    }
    
    func goToBuyAvatarSheet(){
        isShowBuyAvatarSheet = true
    }
    
}
