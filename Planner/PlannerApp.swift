//
//  PlannerApp.swift
//  Planner
//
//  Created by yusufyakuf on 2023-11-19.
//

import SwiftUI

@main
struct PlannerApp: App {
   @StateObject var plansVM = PlansViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
              .environmentObject(plansVM)
        }
    }
}
