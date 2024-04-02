//
//  Priority_view.swift
//  sidequest_1.0
//
//  Created by Denisa Kršková on 07/01/2024.
//

import SwiftUI

struct PriorityTask: Identifiable, Codable {
    var id = UUID()
    let name: String
    
}

@Observable
class PriorityTasks {     
    var itemsPriority = [PriorityTask]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(itemsPriority) {
                UserDefaults.standard.set(encoded, forKey: "ItemsPriority")
            }
        }
    }
    init() {
        if let savedItemsPriority = UserDefaults.standard.data(forKey: "ItemsPriority") {
            if let decodedItemsPriority = try? JSONDecoder().decode([PriorityTask].self, from: savedItemsPriority) {
                itemsPriority = decodedItemsPriority
                return
            }
        }
        itemsPriority = []
    }
}

struct Priority_view: View {
    @State private var tasksPriority = PriorityTasks()
    @State private var priority1 = ""
    
    var body: some View {
        VStack{
            Spacer();Spacer();Spacer();Spacer();Spacer()
            Text("priority of today")
                .font(.title)
                .bold()
                .foregroundColor(.indigo)
            
            List{
                if tasksPriority.itemsPriority.count == 0 {
                    TextField("first thing", text: $priority1)
                    
                    Button (action : addPriority) {
                        Text ("Set")
                    }
                }
                ForEach(tasksPriority.itemsPriority) { item in
                    VStack {
                        Text(item.name)
                            .font(.headline)
                    }
                }
                .onDelete(perform: removeTasks)
            }
        }
    }
    
    func addPriority() {
        tasksPriority.itemsPriority.append(PriorityTask(name: priority1))
    }
    
    func removeTasks(at offsets: IndexSet) {
        tasksPriority.itemsPriority.remove(atOffsets: offsets)
    }
}

#Preview {
    Priority_view()
}
