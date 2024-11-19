//
//  AddHabitView.swift
//  Habit
//
//  Created by khallouk elias on 07/02/2024.
//

import SwiftUI

struct AddSettingsView: View {
    
    @State var notificationTitle: String = ""
    @State var habitNumber: Int = 0
    @State var priority: Priority = .normal
    
    @State var wakeUp = Date.now
    
    @EnvironmentObject var data: HabitViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TextField("Enter your notification",text: $notificationTitle)
                .padding(.horizontal)
                .frame(height:55)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            DatePicker("Enter the hour", selection: $wakeUp, displayedComponents: .hourAndMinute)
            
            Button{
                data.addNotification(name: notificationTitle, time: wakeUp)
                presentationMode.wrappedValue.dismiss()
            }label: {
                Text("Save")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(14)
        .navigationTitle("Add a Notification")
    }
}

struct AddSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddSettingsView()
        }
       
    }
}
