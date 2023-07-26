//
//  Model.swift
//  ToDoList
//
//  Created by Andrey Zharov on 24.07.2023.
//

import Foundation


class ToDoItem: Codable {
    
    var title: String
    var date: Date
    var isComplited: Bool
    
    init(title: String, date: Date, isComplited: Bool) {
        self.title = title
        self.date = date
        self.isComplited = isComplited
    }
}


class Model {
    
    var items: [ToDoItem] = []
    
    init() {
        loadData()
    }
    
    func addItem(title: String) {
        items.append(ToDoItem(title: title, date: Date(), isComplited: false))
        saveData()
    }
    
    func deleteItem(atIndex index: Int) {
        items.remove(at: index)
        saveData()
    }
    
    func renameItem(atIndex index: Int, newTitle: String) {
        items[index].title = newTitle
        saveData()
    }
    
    func toggleItem(atIndex index: Int) {
        items[index].isComplited.toggle()
        saveData()
    }
    
    let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appending(path: "database.data")
    
    private func saveData() {
        let data = try? JSONEncoder().encode(items)
        try? data?.write(to: url)
    }
    
    private func loadData() {
        if let data = try? Data(contentsOf: url) {
            items = (try? JSONDecoder().decode([ToDoItem].self, from: data)) ?? []
        }
    }
}
