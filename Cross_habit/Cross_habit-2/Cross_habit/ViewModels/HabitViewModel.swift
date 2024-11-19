//
//  HabitViewModel.swift
//  Habit
//
//  Created by khallouk elias on 07/02/2024.
//

import Foundation
import UserNotifications

class HabitViewModel: ObservableObject{
    @Published var habits: [Habit] = []
    @Published var habitsWeek: [[Habit]] = []
    @Published var notifications: [Notification] = []
    @Published var username: String = "New User"
    @Published var tabTime: [String] = []
    
    
    init(){
        getHabits()
        getNotifications()
        habitsWeek = generateRandomDataForLastWeek() // Appel de la fonction dans l'init
        tabTime = getTimeWeek()
    }
    
    func getHabits(){
        habits.append(contentsOf: Habit.testData)
    }
    
    func deleteItem(indexSet: IndexSet){
        habits.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        habits.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, number:Int, priority:Priority){
        let newHabit = Habit(title: title, isCompleted: false, number: number, priority: priority, date:Date.now)
        habits.append(newHabit)
        habitsWeek[7].append(newHabit)
    }
    
    func updateItem(habit: Habit){
        for(index,td) in habits.enumerated(){
            if(td.id == habit.id){
                habits[index].isCompleted.toggle()
                habitsWeek[7][index].isCompleted.toggle()
                if(habits[index].isCompleted){
                    habits[index].date = Date.now
                    habitsWeek[7][index].date = Date.now
                }else{
                    habits[index].date = Date.now
                    habitsWeek[7][index].date = Date.now
                }
            }
        }
    }
    
    func getNotifications(){
        notifications.append(contentsOf: Notification.testData)
    }
    
    func deleteNotification(indexSet: IndexSet){
        notifications.remove(atOffsets: indexSet)
    }
    
    func moveNotification(from: IndexSet, to: Int){
        notifications.move(fromOffsets: from, toOffset: to)
    }
    
    func addNotification(name: String, time:Date){
        let newNotification = Notification(name: name, time: time)
        notifications.append(newNotification)
    }
    
    func changeUsername(name: String) {
        self.username = name;
    }
    
    func generateRandomDataForLastWeek() -> [[Habit]] {
        var habitsByDay: [[Habit]] = [[], [], [], [], [], [], [], []]

        for i in 1...6 {
            let currentDate = Date().addingTimeInterval(TimeInterval(-i * 24 * 60 * 60)) // remonter de i jours
            var habitsForDay: [Habit] = []

            for _ in 1...3 {
                let randomTitle = "Task \(Int.random(in: 1...100))"
                let randomIsCompleted = Bool.random()
                let randomNumber = Int.random(in: 1...10)
                let randomPriority = Priority.allCases.randomElement()!

                let habit = Habit(title: randomTitle, isCompleted: randomIsCompleted, number: randomNumber, priority: randomPriority, date: currentDate)

                habitsForDay.append(habit)
            }

            habitsByDay[7 - i] = habitsForDay // Assigner les habitudes pour le jour actuel - i
        }

        let todayHabits = self.habits.filter { Calendar.current.isDateInToday($0.date) }
        habitsByDay[7].append(contentsOf: todayHabits)

        return habitsByDay
    }
    
    func getTimeWeek() -> [String] {
        var tabTimeWeek: [String] = []
        for i in 0...7 {
            if !habitsWeek[i].isEmpty {
                tabTimeWeek.append(habitsWeek[i][0].formattedDate())
            }
        }
        return tabTimeWeek
    }
    
    func calculateAverage() -> [Double] {
        var totalCompleted = 0
        var totalUncompleted = 0
        var totalTask = 0
        
        // Calculer la somme des nombres d'habitudes complétées et non complétées
        for dayHabits in habitsWeek {
            for habit in dayHabits {
                if habit.isCompleted {
                    totalCompleted += 1
                } else {
                    totalUncompleted += 1
                }
                totalTask += 1
            }
        }
        
        // Calculer les moyennes
        let averageCompleted = totalTask != 0 ? Double(totalCompleted) / Double(totalTask) : 0
        let averageUncompleted = totalTask != 0 ? Double(totalUncompleted) / Double(totalTask) : 0
        
        return [averageCompleted, averageUncompleted]
    }
    
    func calculateProgress() -> Double {
        guard !habits.isEmpty else { return 0 }
        
        let completedTasksCount = habits.filter { $0.isCompleted }.count
        let totalTasksCount = habits.count
        return Double(completedTasksCount) / Double(totalTasksCount)
    }

    func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.name
            content.body = "It's time for (notification.name)"

            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: notification.time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

            let request = UNNotificationRequest(identifier: notification.id.uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: (error.localizedDescription)")
                } else {
                    print("Notification scheduled: (notification.name)")
                }
            }
        }
    }

}
