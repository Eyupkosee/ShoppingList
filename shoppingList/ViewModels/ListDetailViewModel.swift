//
//  ListDetailViewModel.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import Foundation

class ListDetailViewModel: ObservableObject {
    @Published var list: ShoppingList
    private let dataManager: DataManager
    
    init(list: ShoppingList, dataManager: DataManager) {
        self.list = list
        self.dataManager = dataManager
    }
    
    func addItem(name: String) {
        let item = ShoppingItem(name: name)
        list.items.append(item)
        saveChanges()
    }
    
    func toggleItemCompletion(item: ShoppingItem) {
        if let index = list.items.firstIndex(where: { $0.id == item.id }) {
            list.items[index].isCompleted.toggle()
            objectWillChange.send()
            
            DispatchQueue.main.async {
                self.saveChanges()
            }
        }
    }
    
    func deleteItem(at indexSet: IndexSet) {
        list.items.remove(atOffsets: indexSet)
        objectWillChange.send()
        
        DispatchQueue.main.async {
            self.saveChanges()
        }
    }
    
    private func saveChanges() {
        if let index = dataManager.shoppingLists.firstIndex(where: { $0.id == list.id }) {
            dataManager.shoppingLists[index] = list
            dataManager.saveLists()
            objectWillChange.send()
            
            NotificationCenter.default.post(name: .listUpdated, object: nil)
        }
    }
}

extension Notification.Name {
    static let listUpdated = Notification.Name("listUpdated")
}
