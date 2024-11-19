//
//  RowView.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import SwiftUI

struct RowView: View {
    
    let habit: Habit
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        HStack{
            Image(systemName: habit.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(habit.isCompleted ? .green : .red)
            Text(habit.title)
            Spacer()
            Text(String(habit.number))
            //Text(habit.date.time)
            //Text(dateFormatter.string(from: habit.date))
            Spacer()
            Text(habit.priority.rawValue)
                .font(.footnote)
                .padding(3)
                .foregroundStyle(Color(.systemGray2))
                .frame(minWidth: 62)
                .overlay(
                    Capsule()
                        .stroke(Color(.systemGray2),lineWidth: 0.75)
                )
        }
        .font(.title2)
        .padding(.vertical, 10)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(habit: Habit.testData[0])
            .previewLayout(.sizeThatFits)
        
        RowView(habit: Habit.testData[1])
            .previewLayout(.sizeThatFits)
        
        RowView(habit: Habit.testData[2])
            .previewLayout(.sizeThatFits)
        
        RowView(habit: Habit.testData[3])
            .previewLayout(.sizeThatFits)
    }
}
