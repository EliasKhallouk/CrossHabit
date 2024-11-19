//
//  Habit.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import Foundation

struct Notification: Identifiable{
    var id = UUID()
    var name: String
    var time: Date
    
    static var testData = [
        Notification(name: "N1", time:Date().addingTimeInterval(120)),
        Notification(name: "N2", time:Date().addingTimeInterval(120)),
    ]
}
