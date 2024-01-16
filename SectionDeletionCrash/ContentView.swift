//
//  ContentView.swift
//  SectionDeletionCrash
//
//  Created by Mike Pinkerton on 1/16/24.
//

import SwiftUI

struct Item: Equatable {
  var name = ""
  var section = ""
}

struct ContentView: View {

  @State var data = [
    Item(name: "A", section: "AAA"),
    Item(name: "B", section: "AAA"),
    Item(name: "C", section: "AAA"),
    Item(name: "D", section: "BBB"),
  ]
  
  @State var dataDictionary = [String: [Item]]()
  @State var sections: [String] = []
  
  @State var listSelection: String? = nil
  
  var body: some View {
    NavigationSplitView {

      //*** Removing the `selection` parameter makes the crash go away. ***
      List(selection: $listSelection) {
        ForEach(sections, id: \.self) { name in

          Section(header: Text(name)) {
            ForEach(dataDictionary[name] ?? [], id: \.name) { item in
              NavigationLink {
                Text(item.name)
              } label: {
                Text(item.name)
              }
            }  // ForEach (elements)
            .onDelete { indexes in
              deleteItems(at: indexes, in: name)
            }
          }  // Section
        } // ForEach (keys)
      }
      .navigationTitle("Items")
      .listStyle(.plain)

    } detail: {
      Text("Select row D, then delete it with swiping.")
    }
    .onAppear() {
      generateSections()
    }
    .onChange(of: data) {
      generateSections()
    }

  }
  
  private func deleteItems(at offsets: IndexSet, in section: String) {
    for index in offsets {
      if let item = dataDictionary[section]?[index] {
        data.removeAll(where: { $0.name == item.name })
      }
    }
  }
  
  private func generateSections() {
    dataDictionary = Dictionary(grouping: data, by: { $0.section })
    sections = Array(dataDictionary.keys.sorted(by: {$0 < $1}))
  }
}

#Preview {
  ContentView()
}
