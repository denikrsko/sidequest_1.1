//
//  Uni_view.swift
//  sidequest_1.0
//
//  Created by Denisa Kršková on 07/01/2024.
//

import SwiftUI

struct UniTask: Identifiable, Codable {
    var id = UUID()
    let name: String
    let deadline: Date
    
    var deadlineShort : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.mm hh:ss"
        return formatter.string(from: deadline)
    }
}

@Observable
class UniTasks {
    var itemsUni = [UniTask]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(itemsUni) {
                UserDefaults.standard.set(encoded, forKey: "ItemsUni")
            }
        }
    }
    init() {
        if let savedItemsUni = UserDefaults.standard.data(forKey: "ItemsUni") {
            if let decodedItemsUni = try? JSONDecoder().decode([UniTask].self, from: savedItemsUni) {
                itemsUni = decodedItemsUni
                return
            }
        }
        itemsUni = []
    }
}


struct Uni_view: View {
    @State private var tasksUni = UniTasks()
    @State private var showingUniAddView = false
    
    var body: some View {
        VStack{
            Text("uni tasks")
                .font(.title)
                .bold()
                .foregroundColor(.mint)
            List {
                ForEach(tasksUni.itemsUni) { item in
                    VStack {
                        Text(item.name)
                            .font(.headline)
                        
                        //Text(item.deadline)
                    }
                }
                .onDelete(perform: removeTasks)
            }
            .toolbar {
                Button ("Add task", systemImage: "plus") {
                    showingUniAddView = true
                }
            }
            .sheet(isPresented: $showingUniAddView) {
                Uni_addview(tasksUni: tasksUni)
            }
        }
    }
    
    func removeTasks(at offsets: IndexSet) {
        tasksUni.itemsUni.remove(atOffsets: offsets)
    }
}

#Preview {
    Uni_view()
}
