//
//  RowView.swift
//  Habit
//
//  Created by khallouk elias on 31/01/2024.
//

import SwiftUI

struct RowViewNot: View {
    
    let notification: Notification
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        HStack{
            Text(notification.name)
            Spacer()
            Text(dateFormatter.string(from: notification.time))
        }
        .font(.title2)
        .padding(.vertical, 10)
    }
}

struct RowViewNot_Previews: PreviewProvider {
    static var previews: some View {
        RowViewNot(notification: Notification.testData[0])
            .previewLayout(.sizeThatFits)
        
        RowViewNot(notification: Notification.testData[1])
            .previewLayout(.sizeThatFits)
    }
}
