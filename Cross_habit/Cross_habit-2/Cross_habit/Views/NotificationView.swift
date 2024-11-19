//
//  AddHabitView.swift
//  Habit
//
//  Created by khallouk elias on 07/02/2024.
//

import SwiftUI

struct NotificationView: View {
    
    @EnvironmentObject var data: HabitViewModel
    
    @State var username: String = ""
    @State var mode: Bool = true
    @State private var wakeUp = Date()
    
    @State var time: Date = Date()
    
    @State var alert = false
    
    var body: some View {
        VStack{
            
            NavigationView{
                List {
                    ForEach(data.notifications) { notification in
                        RowViewNot(notification: notification)
                    }
                    .onDelete(perform: data.deleteNotification)
                    .onMove(perform: data.moveNotification)
                }
                .navigationTitle("Your notifications")
                .listStyle(.insetGrouped)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink("Add",destination: AddSettingsView())
                    }
                }
            }
            
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                        alert = true
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            .foregroundColor(alert ? .green : .red)
            
            Button("Schedule Notification") {
                let currentDate = Date()
                for notification in data.notifications {
                    let timeDifference = notification.time.timeIntervalSince(currentDate)
                    print("Time difference for \(notification.name): \(Int(timeDifference)) seconds")
                    
                    if timeDifference > 0 {
                        let content = UNMutableNotificationContent()
                        content.title = notification.name
                        content.subtitle = "Hey ! Don't forget to do your tasks !"
                        content.sound = UNNotificationSound.default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeDifference, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                    }
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
            .environmentObject(HabitViewModel())
        
    }
}
