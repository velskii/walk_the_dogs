

import HealthKit
import SwiftUI

struct HealthView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistics( statisticsCollection: HKStatisticsCollection ) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate){ (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            
            steps.append(step)
            
        }
        steps.sort{ $0.date > $1.date }
        
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



