//
//  Activities.swift
//  HabitTracking
//
//  Created by 山崎宏哉 on 2021/07/10.
//

import Foundation

struct Activity: Identifiable, Codable {
  var id = UUID()
  var name: String
  var description: String
  var achieveDates: [Date]
}

class Activities: ObservableObject {
  static let key = "Activity"

  @Published var items: [Activity] = [] {
    didSet {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: Self.key)
      }
    }
  }

  init() {
    if let items = UserDefaults.standard.data(forKey: Self.key) {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([Activity].self, from: items) {
        self.items = decoded
        return
      }
    }

    self.items = []
  }

  func getIndex(from activity: Activity) -> Int? {
    for i in 0..<items.count {
      if activity.id == items[i].id {
        return i
      }
    }
    return nil
  }

}

