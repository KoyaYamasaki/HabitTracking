//
//  ContentView.swift
//  HabitTracking
//
//  Created by 山崎宏哉 on 2021/07/10.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var activities = Activities()
  @State private var isAddingItem = false
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        HStack {
          Spacer()
          Text("Today : ")
          Text("\(Date().dayAndMonth)")
        }
        .font(.title2)
        .padding()
        .foregroundColor(.gray)
        
        List {
          ForEach(activities.items) { activity in
            NavigationLink(
              destination: DetailView(activities: activities, activity: activity),
              label: {
                VStack(alignment: .leading) {
                  Text(activity.name)
                  Text(activity.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
              })
          }
          .onDelete(perform: { indexSet in
            activities.items.remove(atOffsets: indexSet)
          })
        }
      }
      .navigationTitle("Habit Tracking")
      .navigationBarItems(
        trailing:
          Button(action: {
            isAddingItem = true
          }, label: {
            Image(systemName: "plus")
          })
      )
      
      .sheet(isPresented: $isAddingItem) {
        AddItemView(activities: activities)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
