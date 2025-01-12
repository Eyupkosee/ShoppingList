//
//  ListDetailViewModel.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import Foundation

class ListDetailViewModel: ObservableObject {
    @Published private(set) var list: ShoppingList
    private let dataManager: DataManager
    
    init(list: ShoppingList, dataManager: DataManager) {
        self.list = list
        self.dataManager = dataManager
    }
    
    func addItem(name: String) {
        let newItem = ShoppingItem(name: name)
        list.items.append(newItem)
        dataManager.updateList(list)
        NotificationCenter.default.post(name: .listUpdated, object: nil)
    }
    
    func toggleItem(_ item: ShoppingItem) {
        if let index = list.items.firstIndex(where: { $0.id == item.id }) {
            list.items[index].isCompleted.toggle()
            dataManager.updateList(list)
            NotificationCenter.default.post(name: .listUpdated, object: nil)
        }
    }
    
    func deleteItems(at indexSet: IndexSet) {
        list.items.remove(atOffsets: indexSet)
        dataManager.updateList(list)
        NotificationCenter.default.post(name: .listUpdated, object: nil)
    }
}

extension Notification.Name {
    static let listUpdated = Notification.Name("listUpdated")
}
