//
//  Habit.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//
import Foundation

enum Priority: String, CaseIterable {
    case all = "All"
    case low = "Low"
    case normal = "Normal"
    case high = "High"
}

enum Done: String, CaseIterable {
    case all = "All"
    case done = "Done"
    case notdone = "Not Done"
}

struct Habit: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    var number: Int
    var priority: Priority
    var date: Date
    
    static var testData = [
        Habit(title: "faire pompe", isCompleted: true, number: 55, priority: .high, date: Date()),
        Habit(title: "faire traction", isCompleted: false, number: 35, priority: .normal, date: Date()),
        Habit(title: "boire litre eau", isCompleted: true, number: 2, priority: .low, date: Date()),
        Habit(title: "courir km", isCompleted: true, number: 6, priority: .high, date: Date())
    ]
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self.date)
    }
}


