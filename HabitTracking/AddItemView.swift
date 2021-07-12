//
//  AddItemView.swift
//  HabitTracking
//
//  Created by 山崎宏哉 on 2021/07/10.
//

import SwiftUI

struct AddItemView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var activities = Activities()
  @State private var name: String = ""
  @State private var description: String = ""

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Name", text: $name)
        }

        Section {
          TextEditor(text: $description)
            .modifier(AddTitle())
        }
      }
      .navigationTitle("Make new habit")
      .navigationBarItems(
      trailing:
        Button("Save") {
          if description.isEmpty {
            description = "No description"
          }

          let item = Activity(name: name, description: description, achieveDates: [])
          activities.items.append(item)
          self.presentationMode.wrappedValue.dismiss()
        }
      )
    }
  }
}

struct AddTitle: ViewModifier {

  func body(content: Content) -> some View {
    return VStack(alignment: .leading) {
      Text("Description")
        .foregroundColor(.gray)
      content
    }
  }
}

struct AddItemView_Previews: PreviewProvider {
  static var previews: some View {
    AddItemView()
  }
}
