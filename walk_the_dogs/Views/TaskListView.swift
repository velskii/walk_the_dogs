/*
Filename:   TaskListView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        List() {
            ForEach(listViewModel.items) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        withAnimation(.linear) {
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteTask)
            .onMove(perform: listViewModel.moveTask)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Task list 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
        .onAppear {
            listViewModel.populateTasks()
        }
        
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TaskListView()
        }
        .environmentObject(ListViewModel())
    }
}
