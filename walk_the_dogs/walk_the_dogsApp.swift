//
//  walk_the_dogsApp.swift
//  walk_the_dogs
//
//  Created by Jerry on 2022-04-03.
//

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
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
            
//            NotificationView()
            
        }
    }
}
