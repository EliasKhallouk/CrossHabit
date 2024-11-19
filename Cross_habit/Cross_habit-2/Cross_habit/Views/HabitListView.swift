//
//  ContentView.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import SwiftUI

struct HabitListView: View {
    
    @EnvironmentObject var data: HabitViewModel
    
    @State private var wakeUp = Date.now
    @State var priority: Priority = .all
    @State var done: Done = .all
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            List {
                ProgressBar(progress: data.calculateProgress())
                    .frame(height: 10)
                    .padding(.horizontal)
                    /*.alert("Important message", isPresented: (data.calculateProgress())==data.habits.count) {
                                Button("OK", role: .cancel) { }
                            }*/
                
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) {
                        priority in
                        Text(priority.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                
                Picker("Done", selection: $done) {
                    ForEach(Done.allCases, id: \.self) {
                        done in
                        Text(done.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                ForEach(data.habits) { habit in
                    if (habit.priority == priority || priority == .all) && (done == .all || (done == .done && habit.isCompleted) || (done == .notdone && !habit.isCompleted)){
                        VStack {
                            RowView(habit: habit)
                                .onTapGesture {
                                    data.updateItem(habit:habit)
                                }
                        }
                    }
                }
                .onDelete(perform: data.deleteItem)
                .onMove(perform: data.moveItem)
                
            }
            .navigationTitle("Welcome " + data.username)
            .listStyle(PlainListStyle())
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink("Add",destination: AddHabitView())
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("\(formattedDate(date: wakeUp))") // Utiliser la fonction formattedDate pour formater la date en anglais
                    }
                }
            }
        }
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
}

struct ProgressBar: View {
    var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .animation(.easeIn)
            }
            .cornerRadius(45.0)
        }
    }
}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitListView()
            .environmentObject(HabitViewModel())
    }
}
