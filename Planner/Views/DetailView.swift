//
//  DetailView.swift
//  Planner
//
//  Created by yusufyakuf on 2023-11-19.
//

import SwiftUI

struct DetailView: View {
   @Environment(\.dismiss) private var dismiss
   @EnvironmentObject var plansVM: PlansViewModel
   @State var plan: Plan
   
    var body: some View {
       List {
          TextField("Enter Plan Here...",text:$plan.item)
             .font(.title2)
             .textFieldStyle(.plain)
             .padding(.vertical)
             .listRowSeparator(.hidden)
          
          Toggle("Set Reminder:", isOn: $plan.remainderIsOn)
             .padding(.top)
             .listRowSeparator(.hidden)
          DatePicker("Date", selection: $plan.dueDate)
             .listRowSeparator(.hidden)
             .padding(.bottom)
             .disabled(!plan.remainderIsOn)
          
          Text("Tasks:")
             .padding(.top)
          TextField("Tasks",text:$plan.notes,axis: .vertical)
             .textFieldStyle(.roundedBorder)
             .listRowSeparator(.hidden)
          
          Toggle("Completed",isOn: $plan.isCompleted)
             .padding(.top)
             .listRowSeparator(.hidden)
       }
       .listStyle(.plain)
       .toolbar {
          ToolbarItem(placement: .navigationBarLeading){
             Button("Cancel") {
                dismiss()
             }
          }
          ToolbarItem(placement: .navigationBarTrailing){
             Button("Save") {
                plansVM.savePlan(plan: plan)
                dismiss()
             }
          }
       }
       .navigationBarBackButtonHidden()
       .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
   NavigationStack {
      DetailView(plan: Plan())
         .environmentObject(PlansViewModel())
   }
   
}
