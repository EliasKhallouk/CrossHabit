//
//  ContentView.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import SwiftUI
import Charts

struct HabitOverView: View {
    @State private var wakeUp = Date.now
    @State private var selectedTime = "Today"
    @EnvironmentObject var data: HabitViewModel // Utiliser l'environnement partagé
    let stats:[String] = ["Done","Not done"]
    
    var body: some View {
        VStack {
            Spacer()
            Picker("Priority", selection: $selectedTime) {
                ForEach(["Today", "Week"], id: \.self) { time in
                    Text(time)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()

            if selectedTime == "Today" {
                VStack {
                    
                    Text("\(formattedDate(date: wakeUp))") // Use the formattedDate function to format the date
                                    .font(.title)
                                    .fontWeight(.heavy)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .frame(height: 525)
                        
                        Chart {
                            BarMark(x: .value("Type", "Not done"),
                                    y: .value("Number", Double(data.habits.filter { !$0.isCompleted }.count)))
                                .foregroundStyle(.pink)

                            BarMark(x: .value("Type", "Done"),
                                    y: .value("Number", Double(data.habits.filter { $0.isCompleted }.count)))
                                .foregroundStyle(.green)
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 500)
                        .padding()
                    }
                }
                .padding()
                Spacer()
            } else if selectedTime == "Week" {
                VStack {
                    Text("From \(formattedDate(date: wakeUp)) \n To \(formattedDate(date: sixDaysAgo))") 
                                    .font(.title)
                                    .fontWeight(.heavy)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .frame(width:300)
                        

                        Chart {
                            
                            ForEach(0..<data.tabTime.count, id: \.self) { index in
                                let habits = data.habitsWeek[index + 1]
                                let pinkCount = Double(habits.filter { !$0.isCompleted }.count)
                                let greenCount = Double(habits.filter { $0.isCompleted }.count)
                                    
                                BarMark(x: .value("Type", data.tabTime[index]),
                                        y: .value("Number", pinkCount))
                                    .foregroundStyle(.pink)
                                    .foregroundStyle(by: .value("Gender", stats[1]))
                                
                                BarMark(x: .value("Type", data.tabTime[index]),
                                        y: .value("Number", greenCount))
                                    .foregroundStyle(.green)
                                    .foregroundStyle(by: .value("Gender", stats[0]))
                            }
                            RuleMark(y: .value("Mean", data.calculateAverage()[0]))
                              .foregroundStyle(.blue)
                              .lineStyle(StrokeStyle(lineWidth: 2))
                            
                            RuleMark(y: .value("Mean", data.calculateAverage()[1]))
                              .foregroundStyle(.black)
                              .lineStyle(StrokeStyle(lineWidth: 2))
                        }
                        .chartForegroundStyleScale(
                            [
                                "Average done = \(String(format: "%.2f", data.calculateAverage()[0]))": Color.blue,
                                "Average not done = \(String(format: "%.2f", data.calculateAverage()[1]))": Color.black,
                                stats[0]: Color.green,
                                stats[1]: Color.pink,
                            ]
                        )
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 500)
                        .padding()
                        
                    }
                }
                .padding()
                Spacer()
            }
        }
        .padding()
    }
    
    private var sixDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -6, to: wakeUp) ?? Date()
    }
    
    // Function to format the date in English
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct HabitOverView_Previews: PreviewProvider {
    static var previews: some View {
        HabitOverView()
            .environmentObject(HabitViewModel())
    }
}
