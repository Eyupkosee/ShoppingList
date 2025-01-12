import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var searchText = ""
    @State private var selectedItems = Set<String>()
    @State private var selectedCategory: ProductCategory?
    
    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Arama ve ekleme alanı
                HStack {
                    TextField("Ürün ara veya yeni ürün ekle", text: $searchText)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            addCustomItem()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                ScrollView {
                    VStack(spacing: 16) {
                        if !searchText.isEmpty {
                            // Özel ürün ekleme önerisi
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Özel Ürün Ekle")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    addCustomItem()
                                }) {
                                    HStack {
                                        Text("\"\(searchText)\" ekle")
                                            .lineLimit(1)
                                        Spacer()
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.blue)
                                            .font(.title3)
                                            .padding(8)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                }
                                .padding(.horizontal)
                            }
                            
                            if !filteredSuggestions.isEmpty {
                                Text("Önerilen Ürünler")
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                                
                                LazyVStack(spacing: 8) {
                                    ForEach(filteredSuggestions, id: \.id) { item in
                                        ProductItemRow(
                                            item: item,
                                            isSelected: selectedItems.contains(item.name),
                                            onTap: { toggleSelection(item.name) }
                                        )
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        } else if selectedCategory == nil {
                            // Kategori grid görünümü
                            LazyVGrid(columns: gridColumns, spacing: 16) {
                                ForEach(ProductCategory.allCases, id: \.self) { category in
                                    CategoryCard(category: category) {
                                        withAnimation {
                                            selectedCategory = category
                                        }
                                    }
                                }
                            }
                            .padding()
                        } else if let category = selectedCategory {
                            // Seçili kategori başlığı
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        selectedCategory = nil
                                    }
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.blue)
                                }
                                
                                Text(category.localizedName)
                                    .font(.headline)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            // Ürün listesi
                            if !filteredSuggestions.isEmpty {
                                LazyVStack(spacing: 8) {
                                    ForEach(filteredSuggestions, id: \.id) { item in
                                        ProductItemRow(
                                            item: item,
                                            isSelected: selectedItems.contains(item.name),
                                            onTap: { toggleSelection(item.name) }
                                        )
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 50)
                    }
                }
                
                if !selectedItems.isEmpty {
                    Text("\(selectedItems.count)"+"ürün seçildi")
                        .foregroundColor(.gray)
                        .padding(.vertical, 8)
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
                    .foregroundColor(Color.theme.mintPrimary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ekle") {
                        addSelectedItems()
                        dismiss()
                    }
                    .disabled(selectedItems.isEmpty)
                    .foregroundColor(selectedItems.isEmpty ? .gray : Color.theme.mintPrimary)
                }
            }
        }
    }
    
    private var filteredSuggestions: [ProductItem] {
        let suggestions = ProductSuggestions.getSuggestions(for: .current())
        var filteredItems = suggestions
        
        if let category = selectedCategory {
            filteredItems = filteredItems.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            filteredItems = filteredItems.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        return filteredItems
    }
    
    private func addCustomItem() {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedText.isEmpty {
            selectedItems.insert(trimmedText)
            searchText = ""
        }
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

struct CategoryCard: View {
    let category: ProductCategory
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Circle()
                    .fill(category.color.opacity(0.2))
                    .overlay(
                        Image(systemName: category.icon)
                            .font(.system(size: 30))
                            .foregroundColor(category.color)
                    )
                    .frame(width: 60, height: 60)
                
                Text(category.localizedName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, maxHeight: 140)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
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
