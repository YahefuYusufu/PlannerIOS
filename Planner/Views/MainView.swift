//
//  ContentView.swift
//  Planner
//
//  Created by yusufyakuf on 2023-11-19.
//

import SwiftUI

struct MainView: View {
   @EnvironmentObject var plansVM : PlansViewModel
   @State private var sheetIsPresented = false
   
   var body: some View {
      NavigationStack {
         List {
            ForEach(plansVM.plans) {plan in
               HStack {
                  Image(systemName: plan.isCompleted ? "checkmark.rectangle" : "rectangle")
                     .onTapGesture {
                        plansVM.toggleCompleted(plan: plan)
                     }
                  NavigationLink {
                     DetailView(plan: plan)
                  } label: {
                     Text(plan.item)
                  }
               }
               .font(.title2)
            }
            .onDelete(perform: plansVM.deletePlan)
            .onMove(perform: plansVM.movePlan)
         }
         .navigationTitle("Plan")
         .navigationBarTitleDisplayMode(.large)
         .listStyle(.plain)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button {
                  sheetIsPresented.toggle()
               } label: {
                  Image(systemName: "plus")
               }
            }
         }
         .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
               DetailView(plan: Plan())
            }
         }
      }
   }
}
#Preview {
   MainView()
      .environmentObject(PlansViewModel())
}
