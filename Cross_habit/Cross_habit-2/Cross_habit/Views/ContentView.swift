//
//  ContentView.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var data: HabitViewModel
    @State private var wakeUp = Date.now
    
    var body: some View {
        TabView {
            HabitListView()
                .padding()
                .tabItem {
                    Label("Habit", systemImage: "list.bullet")
                }
                .tag(1)
            
            HabitOverView()
                .padding()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Over View")
                }
                .tag(2)
            
            SettingsView()
                .padding()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HabitViewModel())
            
    }
}
