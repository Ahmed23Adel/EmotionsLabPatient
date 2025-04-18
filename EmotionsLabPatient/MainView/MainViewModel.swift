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
    @Published var numTodaySessions = 7
    private let apiCaller = ApiCaller()
    private let timePeriod = TimePeriod()
    @Published private var timePeriodLoading = false
    init(){
        Task{
            await loadActiveTimePeriod()
        }
        
    }
    
    
    private func loadActiveTimePeriod() async{
        do {
            timePeriodLoading = true
            try await timePeriod.loadActiveTimePeriod()
            timePeriodLoading = false
        } catch TimePeriodError.noTimePeriod{
            showNoActivePeriod()
        } catch {
            
        }
    }
    
    
    private func showNoActivePeriod(){
        timePeriodLoading = false
        isActiveTimePeriod = false
    }
    
    
}
