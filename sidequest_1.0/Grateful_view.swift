//
//  Grateful_view.swift
//  sidequest_1.0
//
//  Created by Denisa Kršková on 07/01/2024.
//

import SwiftUI

struct GratefulTask: Identifiable, Codable {
    var id = UUID()
    let name: String
    
}

@Observable
class GratefulTasks {
    var itemsGrateful = [GratefulTask]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(itemsGrateful) {
                UserDefaults.standard.set(encoded, forKey: "ItemsGrateful")
            }
        }
    }
    init() {
        if let savedItemsGrateful = UserDefaults.standard.data(forKey: "ItemsGrateful") {
            if let decodedItemsGrateful = try? JSONDecoder().decode([GratefulTask].self, from: savedItemsGrateful) {
                itemsGrateful = decodedItemsGrateful
                return
            }
        }
        itemsGrateful = []
    }
}

struct Grateful_view: View {
    @State private var tasksGrateful = GratefulTasks()
    @State private var grateful1 = ""
    @State private var grateful2 = ""
    @State private var grateful3 = ""
    
    var body: some View {
        VStack{
            Spacer();Spacer();Spacer();Spacer();Spacer()
            Text("3 things i am grateful for...")
                .font(.title)
                .bold()
                .foregroundColor(.orange)
            List {
                if tasksGrateful.itemsGrateful.count == 0 {
                    TextField("first thing", text: $grateful1)
                    TextField("second thing", text: $grateful2)
                    TextField("third thing", text: $grateful3)
                    
                    Button (action : addGrateful0) {
                        Text ("Set")
                    }
                }
                if tasksGrateful.itemsGrateful.count == 1 {
                    TextField("second thing", text: $grateful2)
                    TextField("third thing", text: $grateful3)
                    
                    Button (action : addGrateful1) {
                        Text ("Set")
                    }
                }
                if tasksGrateful.itemsGrateful.count == 2 {
                    TextField("third thing", text: $grateful3)
                    
                    Button (action : addGrateful2) {
                        Text ("Set")
                    }
                }
                
                ForEach(tasksGrateful.itemsGrateful) { item in
                    VStack {
                        Text(item.name)
                            .font(.headline)
                    }
                }
                .onDelete(perform: removeTasks)
            }
        }
    }
    
    func addGrateful0() {
        tasksGrateful.itemsGrateful.append(GratefulTask(name: grateful1))
    }
    func addGrateful1() {
        tasksGrateful.itemsGrateful.append(GratefulTask(name: grateful2))
    }
    func addGrateful2() {
        tasksGrateful.itemsGrateful.append(GratefulTask(name: grateful3))
    }
    
    func removeTasks(at offsets: IndexSet) {
        tasksGrateful.itemsGrateful.remove(atOffsets: offsets)
    }
    
    
}
#Preview {
    Grateful_view()
}
