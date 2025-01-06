import Foundation

struct ShoppingList: Identifiable, Codable {
    let id: UUID
    var name: String
    var items: [ShoppingItem]
    var category: String
    
    init(id: UUID = UUID(), name: String, items: [ShoppingItem] = [], category: String = "Genel") {
        self.id = id
        self.name = name
        self.items = items
        self.category = category
    }
}

struct ShoppingItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }
} 