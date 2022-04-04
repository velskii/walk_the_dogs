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
    
    init(){
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
        }
    }
}
