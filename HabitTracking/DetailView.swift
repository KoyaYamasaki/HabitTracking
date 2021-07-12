//
//  DetailView.swift
//  HabitTracking
//
//  Created by 山崎宏哉 on 2021/07/10.
//

import SwiftUI

struct DetailView: View {
  @ObservedObject var activities: Activities
  let activity: Activity
  let todayDate = Date()
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(spacing: 5) {
          HStack {
            Text("Today : ")
              .foregroundColor(.gray)
            Text("\(todayDate.dayAndMonth)")
              .foregroundColor(.gray)
          }
          Text("Achieve Count: \(activity.achieveDates.count)")
        }
        .padding(.leading, 15)
        
        Spacer()
        if isAlreadyAchieve {
          Button("UNDONE") {
            let index: Int = activities.getIndex(from: activity)!
            activities.items[index].achieveDates.removeLast()
          }
          .modifier(ButtonModifier(width: 80))
        } else {
          Button("DONE") {
            let index: Int = activities.getIndex(from: activity)!
            activities.items[index].achieveDates.append(todayDate)
          }
          .modifier(ButtonModifier(width: 60))
        }
      }
      
      Divider().frame(height: 10)
      Text("Note : \(activity.description)")
        .padding(.leading)
      
      List {
        Section(header: Text("Achieve Dates")) {
          ForEach(activity.achieveDates, id: \.self) { date in
            Text(date.dayAndMonth)
          }
        }
      }
    } //: VStack
    .navigationTitle(activity.name)
  } //: Body
  
  var isAlreadyAchieve: Bool {
    let result = activity.achieveDates.first(where: { $0.dayAndMonth == todayDate.dayAndMonth })
    
    return result != nil ? true : false
  }
}

struct ButtonModifier: ViewModifier {
  var width: CGFloat
  
  func body(content: Content) -> some View {
    content
      .frame(width: width)
      .padding()
      .foregroundColor(.white)
      .background(Color.blue)
      .clipShape(Capsule())
      .padding(.trailing, 10)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    let calendar = Calendar.current
    let date = Date()
    
    let yesterday = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: date))
    //    DetailView(activity: Activity(name: "test", description: "Test", achieveDates: [yesterday!]))
    DetailView(activities: Activities(), activity: Activity(name: "test", description: "Test", achieveDates: [yesterday!]))
      .previewDevice("iPhone 12")
  }
}
