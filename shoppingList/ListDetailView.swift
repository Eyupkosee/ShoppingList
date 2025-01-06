import SwiftUI

struct ListDetailView: View {
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var searchText = ""
    @State private var showingAddItem = false
    
    var filteredItems: [ShoppingItem] {
        if searchText.isEmpty {
            return viewModel.list.items
        } else {
            return viewModel.list.items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Özel arama çubuğu
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        TextField("Ürün ara", text: $searchText)
                            .autocapitalization(.none)
                        
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding()
                
                // Liste görünümü
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(filteredItems) { item in
                            ItemRow(item: item) {
                                viewModel.toggleItem(item)
                            } onDelete: {
                                if let index = viewModel.list.items.firstIndex(where: { $0.id == item.id }) {
                                    viewModel.deleteItems(at: IndexSet([index]))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Yeni ürün ekleme butonu
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showingAddItem = true }) {
                        Image(systemName: "plus")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .padding([.trailing, .bottom], 20)
                }
            }
        }
        .navigationTitle(viewModel.list.name)
        .sheet(isPresented: $showingAddItem) {
            AddItemView(viewModel: viewModel)
        }
    }
}

// Özel ürün satırı görünümü
struct ItemRow: View {
    let item: ShoppingItem
    let onToggle: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(item.isCompleted ? .green : .gray)
            }
            .padding(.trailing, 4)
            
            Text(item.name)
                .strikethrough(item.isCompleted)
                .foregroundColor(item.isCompleted ? .gray : .primary)
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}

// Yeni ürün ekleme modal view
struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var newItemName = ""
    @FocusState private var isInputFocused: Bool
    @State private var selectedItems = Set<String>()
    
    // Önerileri filtrele
    private var filteredSuggestions: [ProductItem] {
        let suggestions = ProductSuggestions.getSuggestions(for: SupportedLanguage.current())
        if newItemName.isEmpty {
            return suggestions
        } else {
            return suggestions.filter { $0.name.localizedCaseInsensitiveContains(newItemName) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Yeni Ürün Ekle")
                    .font(.title2.bold())
                    .padding(.top)
                
                TextField("Ürün adı", text: $newItemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .focused($isInputFocused)
                
                // Öneriler ScrollView
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(filteredSuggestions) { suggestion in
                            HStack {
                                Text(suggestion.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Button(action: {
                                    toggleSelection(suggestion.name)
                                }) {
                                    Image(systemName: selectedItems.contains(suggestion.name) ? "checkmark.circle.fill" : "plus.circle")
                                        .foregroundColor(selectedItems.contains(suggestion.name) ? .green : .blue)
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Butonlar
                HStack(spacing: 20) {
                    Button("İptal") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
                    
                    Button {
                        if !newItemName.isEmpty {
                            viewModel.addItem(name: newItemName)
                        }
                        addSelectedItems()
                        dismiss()
                    } label: {
                        Text("Ekle")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background((selectedItems.isEmpty && newItemName.isEmpty) ? Color.blue.opacity(0.5) : Color.blue)
                            .cornerRadius(12)
                    }
                    .disabled(selectedItems.isEmpty && newItemName.isEmpty)
                }
                .padding(.horizontal)
            }
            .onAppear {
                isInputFocused = true
            }
        }
    }
    
    // Yeni fonksiyonlar
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
        selectedItems.removeAll()
    }
}
