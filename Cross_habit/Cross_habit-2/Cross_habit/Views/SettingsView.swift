//
//  AddHabitView.swift
//  Habit
//
//  Created by khallouk elias on 07/02/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("theme") var theme = 0
    
    @EnvironmentObject var data: HabitViewModel
    @State var username: String = ""
    @State var mode: Bool = true
    @State private var wakeUp = Date.now
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent("Cross Habit Version", value: "1.7")
                
                Section("Username") {
                    LabeledContent("Username", value: data.username)
                    if mode {
                        Button{
                            mode.toggle()
                        }label: {
                            Text("Change Name")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .frame(height:30)
                                .background(.blue)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    else {
                        HStack {
                            TextField("Enter your name",text: $username)
                                .padding(.horizontal)
                                .frame(height:30)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                            
                            Button{
                            }label: {
                                Text("Cancel")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .frame(height:30)
                                    .background(.red)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        username = ""
                                        mode = true
                                    }
                            }
                            
                            
                            Button{
                            }label: {
                                Text("Confirm")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .frame(height:30)
                                    .background(.green)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        data.username = username
                                        username = ""
                                        mode = true
                                    }
                            }
                        }
                    }
                }
                
                Section("Notification") {
                    NavigationLink(destination: NotificationView()) {
                        Text("Watch my notifications")
                    }
                }
     
                Picker("Theme", selection: $theme) {
                    Text("Light")
                        .tag(0)
                    Text("Dark")
                        .tag(1)
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Settings")
            .preferredColorScheme(theme == 0 ? .light : .dark)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(HabitViewModel())
        
    }
}
