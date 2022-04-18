/*
Filename:   HealthView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import HealthKit
import SwiftUI
import Firebase
import FirebaseCore

struct HealthView: View {
    
    var db = Firestore.firestore()
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    
    private func updateUIFromStatistics( statisticsCollection: HKStatisticsCollection ) {
        steps = [Step]()
        db.collection("settings").document("health")
            .getDocument { (document, error) in
            if let document = document, document.exists {
                let d = Int(document.data()!["days"] as! String)! - 1
                let startDate = Calendar.current.date(byAdding: .day, value: -d, to: Date())!
                let endDate = Date()
                
                
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate){ (statistics, stop) in
                    
                    let count = statistics.sumQuantity()?.doubleValue(for: .count())
                    
                    let step = Step(count: Int(count ?? 0), date: statistics.startDate)
                    
                    steps.append(step)
                    
                }
                steps.sort{ $0.date > $1.date }
            } else {
                print("Document does not exist")
            }
            
             
        }
        
        
        
    }
    
    var body: some View {
        
        NavigationView{
            List(steps, id: \.id) { step in
                VStack(alignment: .leading) {
                    Text("\(step.count)")
                    Text(step.date, style: .date)
                        .opacity(0.5)
                }
            }
            .frame( maxHeight: .infinity )
            .navigationTitle("Walking steps")
        }
        
       
            .onAppear{
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        if success {
                            healthStore.calculateSteps{ statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    
//                                    print(statisticsCollection)
                                    updateUIFromStatistics(statisticsCollection: statisticsCollection)
                                    
                                    
                                }
                            }
                        }
                    }
                }
                
                
            }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}



