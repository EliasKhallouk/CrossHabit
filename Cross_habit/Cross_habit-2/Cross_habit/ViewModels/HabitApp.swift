//
//  HabitApp.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HabitViewModel())
            
        }
    }
}
