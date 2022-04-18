

import SwiftUI
import Firebase

@main
struct walk_the_dogsApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    private var delegate: NotificationDelegate = NotificationDelegate()
    
    init(){
        FirebaseApp.configure()
        
        
        let center = UNUserNotificationCenter.current()
        center.delegate = delegate
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if let error = error {
                print(error)
            }
            
        }
    }
//    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
//            TaskListView()
//            HealthView()
            
//            NavigationView{
//                TaskListView()
//            }
//            .environmentObject(listViewModel)
        }
    }
}
