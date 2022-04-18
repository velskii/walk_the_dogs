

import SwiftUI
import Firebase
import FirebaseCore

struct SettingsView: View {
    
    @State var days: String = ""
    
    var db = Firestore.firestore()
    
    private func getSettings(){
        db.collection("settings").document("health")
            .getDocument { (document, error) in
            if let document = document, document.exists{
                self.days = document.get("days") as! String
            } else {
                print("Document does not exist")
            }
        }
    }
                          
    private func saveSettings(){
        db.collection("settings").document("health").setData([
                "days": days,
            ]) { error in
            if let error = error{
                print(error)
            } else {
                print("data is inserted successfully")
            }
        }
        
    }
    var body: some View {
        
        NavigationView{
            Form {
                Section(header: Text("HEALTH")) {
                    TextField("Days of displaying steps (Detfault: 8)", text: $days)
                        .padding(.horizontal)
                        .cornerRadius(10)
                    HStack {
                        Text("Days")
                        Spacer()
                        Text(days)
                    }
                    
                }

                Section(header: Text("ABOUT")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("2.2.1")
                    }
                }
                Section {
                    Button(action: {
                        self.days = "8"
                        saveSettings()
                    }) {
                        Text("Reset All Settings")
                    }
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    saveSettings()
                }) {
                    Text("Save")
                }
            )
            .navigationBarTitle("Settings")
            .onAppear{
                getSettings()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
