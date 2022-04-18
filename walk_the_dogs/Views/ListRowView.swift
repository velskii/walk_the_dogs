
/*
Filename:   ListRowView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct ListRowView: View {
    let item: TaskModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = TaskModel(title: "first item.", isCompleted: false)
    static var item2 = TaskModel(title: "second item.", isCompleted: true)
    
    static var previews: some View {
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
        
       
    }
}
