import Foundation

class DataManager: ObservableObject {
    @Published var shoppingLists: [ShoppingList] = []
    private let saveKey = "ShoppingLists"
    
    init() {
        loadLists()
    }
    
    func loadLists() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decodedLists = try? JSONDecoder().decode([ShoppingList].self, from: data) {
            shoppingLists = decodedLists
        }
    }
    
    func saveLists() {
        if let encoded = try? JSONEncoder().encode(shoppingLists) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func addList(_ list: ShoppingList) {
        shoppingLists.append(list)
        saveLists()
    }
    
    func deleteList(at indexSet: IndexSet) {
        shoppingLists.remove(atOffsets: indexSet)
        saveLists()
    }
    
    func updateList(_ updatedList: ShoppingList) {
        if let index = shoppingLists.firstIndex(where: { $0.id == updatedList.id }) {
            shoppingLists[index] = updatedList
            saveLists()
        }
    }
} 