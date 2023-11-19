//
//  Plans.swift
//  Planner
//
//  Created by yusufyakuf on 2023-11-19.
//

import Foundation

struct Plan: Identifiable, Codable  {
   
   var id: String?
   var item = ""
   var remainderIsOn = false
   var dueDate = Date.now + (60*60*24)
   var notes = ""
   var isCompleted = false
   
}

