//
//  ShoppingListViewModel.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import Foundation

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingLists: [ShoppingList] = []
    private let dataManager: DataManager
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
        self.shoppingLists = dataManager.shoppingLists
        
        // Notification observer ekle
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshLists),
            name: .listUpdated,
            object: nil
        )
    }
    
    @objc private func refreshLists() {
        DispatchQueue.main.async {
            self.shoppingLists = self.dataManager.shoppingLists
        }
    }
    
    func createListDetailViewModel(for list: ShoppingList) -> ListDetailViewModel {
        return ListDetailViewModel(list: list, dataManager: dataManager)
    }
    
    func addNewList(name: String, items: [ShoppingItem] = []) {
        let newList = ShoppingList(name: name, items: items)
        dataManager.addList(newList)
        shoppingLists = dataManager.shoppingLists
    }
    
    func deleteList(at indexSet: IndexSet) {
        dataManager.deleteList(at: indexSet)
        shoppingLists = dataManager.shoppingLists
    }
}
