//
//  PlansViewModel.swift
//  Planner
//
//  Created by yusufyakuf on 2023-11-19.
//

import Foundation

class PlansViewModel: ObservableObject {
   @Published var plans:[Plan] = [] 
   
   init() {
      loadData()
   }

   
   func toggleCompleted(plan:Plan) {
      guard plan.id != nil else {return}
      
      var newPlan = plan
      newPlan.isCompleted.toggle()
      
      if let index = plans.firstIndex(where: {$0.id == newPlan.id}) {
         plans[index] = newPlan
      }
      saveData()
   }
   
   func savePlan(plan: Plan) {
      if plan.id == nil {
         var newPlan = plan
         newPlan.id = UUID().uuidString
         plans.append(newPlan)
      } else {
         if let index = plans.firstIndex(where: {$0.id == plan.id}) {
            plans[index] = plan
         }
      }
      saveData()
   }
   
   func deletePlan(indexSet: IndexSet) {
      plans.remove(atOffsets: indexSet)
      saveData()
   }
   
   func movePlan(fromOffsets: IndexSet, toOffset: Int) {
      plans.move(fromOffsets: fromOffsets, toOffset: toOffset)
   }
   
   func loadData() {
      let path = URL.documentsDirectory.appending(component: "plans")
      guard let data = try? Data(contentsOf: path) else {return}
      do {
         plans = try JSONDecoder().decode(Array<Plan>.self, from: data)
      } catch {
         print("😡 ERROR: Could not save data \(error.localizedDescription)")
      }
   }
   
   func saveData() {
      let path = URL.documentsDirectory.appending(component: "plans")
      let data = try? JSONEncoder().encode(plans)
      do {
         try data?.write(to: path)
      } catch {
         print("😡 ERROR: Could not save data \(error.localizedDescription)")
      }
   }
}
