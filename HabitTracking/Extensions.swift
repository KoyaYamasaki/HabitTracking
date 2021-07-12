//
//  Extensions.swift
//  HabitTracking
//
//  Created by 山崎宏哉 on 2021/07/10.
//

import Foundation

extension Date {
  var dayAndMonth: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    return dateFormatter.string(from: self)
  }
}
