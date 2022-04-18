/*
Filename:   TodoListView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-18.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject var viewModelForTodo: TodoListViewModel
    @State private var searchText = ""
    @State private var isShowingDeleteItemsConfirmationDialog = false

    private var searchBinding: Binding<String> {
        Binding<String>(
            get: { return self.searchText },
            set: { newSearchText in
                withAnimation {
                    self.searchText = newSearchText
                }
            }
        )
    }



    var body: some View {
       NavigationView {
           VStack(spacing: 0) {
               if viewModelForTodo.todoListIsEmpty {
                   Text("Add tasks by tapping the plus button")
                       .font(.largeTitle)
                       .offset(y: Constants.onboardingHeaderYOffset)
                       .padding()
               } else {
                   List {
                       ForEach(viewModelForTodo.filteredListOfTodosByTitle(searchText)) { todoItem in
                           ListItemView(todoItem: todoItem)
                       }
                       .onDelete {
                           viewModelForTodo.remove(indexSet: $0)
                       }
                   }
                   .searchable(text: searchBinding)
               }
           }
           .navigationTitle("Schedule")
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button(role: .destructive) {
                       isShowingDeleteItemsConfirmationDialog = true
                   } label: {
                       Label("Delete", systemImage: "trash")
                   }
                   .disabled(viewModelForTodo.todoListIsEmpty)
                   .confirmationDialog(
                       "Are you sure you want to delete items?",
                       isPresented: $isShowingDeleteItemsConfirmationDialog,
                       titleVisibility: .visible
                   ) {
                       Button("Remove completed items", role: .destructive) {
                           withAnimation {
                               viewModelForTodo.removeCompleted()
                           }
                       }
                       .disabled(viewModelForTodo.todoListHasNoCompletedItems)

                       Button("Remove all items", role: .destructive) {
                           withAnimation {
                               viewModelForTodo.removeAll()
                           }
                       }
                   }
               }

               ToolbarItem(placement: .navigationBarTrailing) {
                   NavigationLink(destination: AddEditTodoView(todoItem: TodoListInfo.TodoItem())) {
                       Image(systemName: "plus")
                   }
               }
           }
       }
       .navigationViewStyle(.stack)
   }

   private struct Constants {
       static let onboardingHeaderYOffset: CGFloat = -50
   }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView().environmentObject(TodoListViewModel(testData: true))
//    }
//}
