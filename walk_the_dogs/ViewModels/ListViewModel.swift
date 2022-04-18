

import Foundation
import Firebase
import FirebaseCore

class ListViewModel: ObservableObject {
    
    let itemsKey: String = "tasks_list"
    @Published var items: [TaskModel] = [] {
        didSet{
            saveItems()
        }
    }
    var db = Firestore.firestore()
    
    init() {
        getItems()
    }
    
    func getItems() {
//        let newItems = [
//            TaskModel(title: "This is the first item", isCompleted: false),
//            TaskModel(title: "This is the second item", isCompleted: true),
//            TaskModel(title: "This is the third item", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        self.items = savedItems
        
    }
    
    func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { index in
            items.remove(at: index)
//            let task = self.tasks[index]
//
//            db.collection("tasks").document(task["documentId"]!).delete() { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
//                    self.populateTasks()
//                    print("delete successfully")
//                }
//
//            }
        }
    }
    func moveTask(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = TaskModel(title: title, isCompleted: false)
        
        items.append(newItem)
        
//        db.collection("tasks").addDocument(data: [
//            "title": textFieldText
//        ]) { error in
//            if let error = error{
//                print(error)
//            } else {
//                print("data is inserted successfully")
//            }
//        }
    }
    
    func updateItem(item: TaskModel) {
        
       
        if let index = items.firstIndex(where: {
            $0.id == item.id
        }) {
            items[index] = item.updateCompletion()
        }
        
        
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    
    func populateTasks() {
//        db.collection("tasks").getDocuments { (snapshot, error) in
//            if let snapshot = snapshot {
//                self.tasks = snapshot.documents.map{ doc in
//                    return [
//                        "title": doc.data()["title"] as! String,
//                        "documentId": doc.documentID
//                    ]
//                }
//            }
//        }
    }
    
}
