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
                  Image(systemName: plan.isCompleted ? "checkmark.seal.fill" : "checkmark.seal")
                     .onTapGesture {
                        plansVM.toggleCompleted(plan: plan)
                     }
                     .font(.title2)
                  NavigationLink {
                     DetailView(plan: plan)
                        .foregroundStyle(.green)
                  } label: {
                     VStack {
                        Text(plan.item)
                           .font(.title)
                        Text(plan.notes)
                           .font(.title3)
                     }
                  }
                  .padding()
               }
               .background(Color.black)
               .foregroundColor(.green)
               .cornerRadius(10)
               
               
            }
            .onDelete(perform: plansVM.deletePlan)
            .onMove(perform: plansVM.movePlan)
         }
         .navigationTitle("Plans")
         .navigationBarTitleDisplayMode(.inline)
         .listStyle(.grouped)
         .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
               Button {
                  sheetIsPresented.toggle()
               } label: {
                  Image(systemName: "plus.square.fill")
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
