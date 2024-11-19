//
//  AddHabitView.swift
//  Habit
//
//  Created by khallouk elias on 07/02/2024.
//

import SwiftUI

struct AddHabitView: View {
    
    @State var habitTitle: String = ""
    @State var habitNumber: Int = 0
    @State var priority: Priority = .normal
    
    @EnvironmentObject var data: HabitViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TextField("Enter your task",text: $habitTitle)
                .padding(.horizontal)
                .frame(height:55)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            TextField("Enter the number",value: $habitNumber, format: .number)
                .padding(.horizontal)
                .frame(height:55)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            Picker("Priority",selection:$priority){
                ForEach(Priority.allCases.dropFirst(),id: \.self){
                    priority in
                    Text(priority.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button{
                data.addItem(title: habitTitle, number: habitNumber, priority: priority)
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
        .navigationTitle("Add an habit")
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddHabitView()
        }
       
    }
}
