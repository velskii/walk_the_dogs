
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesManager: ObservableObject{
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId = ""
    
    let db = Firestore.firestore()
    
    init(){
        getMessages()
    }
    
    func getMessages(){
        db.collection("messages").addSnapshotListener{ QuerySnapshot, error in
            guard let documents = QuerySnapshot?.documents else {
                print("Error fetching documents \(String(describing: error))")
                return
            }
            self.messages = documents.compactMap{ document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding documents into Message\(error)")
                    return nil
                }
                
            }
                    
            self.messages.sort{ $0.timestamp < $1.timestamp }
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func sendMessage(text: String){
        do{
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            try db.collection("messages").document().setData(from: newMessage)
        } catch {
            print("Error adding message to Firebasestore: \(error)")
        }
    }
    
}
