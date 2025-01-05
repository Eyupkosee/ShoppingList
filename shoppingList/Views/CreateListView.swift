//
//  CreateListView.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import SwiftUI

struct CreateListView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @State private var listName = ""
    @State private var showAlert = false
    @State private var initialItems: [String] = ["", ""]
    @State private var shouldAddNewItem = false
    @State private var itemUpdateIndex: Int? = nil
    @State private var itemUpdateText: String = ""
    @Binding var selectedTab: Int
    @State private var filteredSuggestions: [ProductItem] = []
    @State private var showItemSuggestions = false
    @State private var activeTextFieldIndex: Int? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Üst görsel
                    Image(systemName: "cart.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    // Liste adı ve öneriler
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Liste Adı")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        TextField("Örn: Market Alışverişi", text: $listName)
                            .textFieldStyle(CustomTextFieldStyle())
                            .textInputAutocapitalization(.words)
                        
                        // Öneriler
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 8) {
                                ForEach(suggestedLists, id: \.self) { suggestion in
                                    Button {
                                        listName = suggestion
                                    } label: {
                                        Text(suggestion)
                                            .font(.subheadline)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color(.systemGray6))
                                            .clipShape(Capsule())
                                    }
                                    .foregroundColor(.primary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Ürünler
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Ürünler")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                            Button {
                                shouldAddNewItem = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        ForEach(Array(initialItems.enumerated()), id: \.offset) { index, item in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    TextField("Ürün adı", text: .init(
                                        get: { item },
                                        set: { newValue in
                                            itemUpdateIndex = index
                                            itemUpdateText = newValue
                                            activeTextFieldIndex = index
                                            filterSuggestions(for: newValue)
                                        }
                                    ))
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .onTapGesture {
                                        activeTextFieldIndex = index
                                        filterSuggestions(for: item)
                                    }
                                    
                                    if initialItems.count > 1 {
                                        Button {
                                            withAnimation {
                                                removeItem(at: index)
                                            }
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                
                                // Öneriler
                                if activeTextFieldIndex == index && !filteredSuggestions.isEmpty {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHStack(spacing: 8) {
                                            ForEach(filteredSuggestions) { suggestion in
                                                Button {
                                                    initialItems[index] = suggestion.name
                                                    activeTextFieldIndex = nil
                                                    filteredSuggestions.removeAll()
                                                } label: {
                                                    Text(suggestion.name)
                                                        .font(.subheadline)
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 6)
                                                        .background(Color(.systemGray6))
                                                        .clipShape(Capsule())
                                                }
                                                .foregroundColor(.primary)
                                            }
                                        }
                                    }
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                    
                    // Oluştur butonu
                    Button(action: {
                        DispatchQueue.main.async {
                            createList()
                        }
                    }) {
                        HStack {
                            Text("Liste Oluştur")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(listName.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(15)
                    }
                    .disabled(listName.isEmpty)
                    .padding()
                }
            }
            .onChange(of: shouldAddNewItem) { newValue in
                if newValue {
                    withAnimation {
                        initialItems.append("")
                    }
                    shouldAddNewItem = false
                }
            }
            .onChange(of: itemUpdateIndex) { index in
                if let index = index {
                    withAnimation {
                        initialItems[index] = itemUpdateText
                    }
                    itemUpdateIndex = nil
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Yeni Liste Oluştur")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        selectedTab = 0
                    }
                }
            }
            .onTapGesture {
                // Boş alana tıklandığında önerileri kapat
                activeTextFieldIndex = nil
                filteredSuggestions.removeAll()
            }
        }
        .alert("Liste Oluşturuldu", isPresented: $showAlert) {
            Button("Tamam") {
                DispatchQueue.main.async {
                    selectedTab = 0
                }
            }
        } message: {
            Text("\"\(listName)\" listesi başarıyla oluşturuldu ve \(initialItems.filter { !$0.isEmpty }.count) ürün eklendi.")
        }
    }
    
    private func removeItem(at index: Int) {
        guard initialItems.count > 1 else { return }
        DispatchQueue.main.async {
            initialItems.remove(at: index)
        }
    }
    
    private func createList() {
        guard !listName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let items = initialItems
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
            .map { ShoppingItem(name: $0) }
        
        viewModel.addNewList(name: listName, items: items)
        showAlert = true
    }
    
    private let suggestedLists = [
        "Market Alışverişi",
        "Haftalık Alışveriş",
        "Kırtasiye",
        "Ev İhtiyaçları",
        "Piknik"
    ]
    
    // Dile göre önerileri al
    private var itemSuggestions: [ProductItem] {
        return ProductSuggestions.getSuggestions(for: SupportedLanguage.current())
    }
    
    // Önerileri filtrele
    private func filterSuggestions(for text: String) {
        let searchText = text.lowercased()
        if searchText.isEmpty {
            filteredSuggestions = []
        } else {
            filteredSuggestions = itemSuggestions
                .filter { item in
                    item.name.lowercased().contains(searchText) ||
                    item.name.folding(options: .diacriticInsensitive, locale: .current)
                        .lowercased()
                        .contains(searchText)
                }
                .prefix(8)
                .sorted { $0.name < $1.name }
        }
    }
}

// TextField stili
private struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

#Preview {
    CreateListView(
        viewModel: ShoppingListViewModel(),
        selectedTab: .constant(0)
    )
}
