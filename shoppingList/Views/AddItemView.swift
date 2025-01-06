import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var searchText = ""
    @State private var selectedItems = Set<String>()
    @State private var selectedCategory: ProductCategory = .beverages
    
    var body: some View {
        NavigationView {
            VStack {
                // Kategori seçim alanı
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(ProductCategory.allCases, id: \.self) { category in
                            CategoryButton(
                                title: category.rawValue,
                                isSelected: selectedCategory == category
                            ) {
                                withAnimation {
                                    selectedCategory = category
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                // Arama alanı
                TextField("Ürün ara veya filtrele", text: $searchText)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal)
                
                // Ürün listesi
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(filteredSuggestions, id: \.id) { item in
                            ProductItemRow(
                                item: item,
                                isSelected: selectedItems.contains(item.name),
                                onTap: { toggleSelection(item.name) }
                            )
                        }
                    }
                    .padding()
                }
                
                if !selectedItems.isEmpty {
                    Text("\(selectedItems.count) ürün seçildi")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                }
            }
            .navigationTitle("Ürün Ekle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        selectedItems.removeAll()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ekle") {
                        addSelectedItems()
                        dismiss()
                    }
                    .disabled(selectedItems.isEmpty)
                }
            }
        }
    }
    
    private var filteredSuggestions: [ProductItem] {
        let suggestions = ProductSuggestions.getSuggestions(for: .current())
        let categoryItems = suggestions.filter { $0.category == selectedCategory }
        if searchText.isEmpty {
            return categoryItems
        }
        return categoryItems.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    private func toggleSelection(_ item: String) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }
    
    private func addSelectedItems() {
        for itemName in selectedItems {
            viewModel.addItem(name: itemName)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct ProductItemRow: View {
    let item: ProductItem
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            Text(item.name)
                .lineLimit(1)
            Spacer()
            Button(action: onTap) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle")
                    .foregroundColor(isSelected ? .green : .blue)
                    .font(.title3)
                    .padding(8)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

private struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
} 