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
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Üst görsel
                Image(systemName: "cart.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                // Liste adı ve öneriler
                VStack(alignment: .leading, spacing: 8) {
                    Text("Liste Adı")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    TextField("Örn: Market Alışverişi", text: $listName)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.words)
                    
                    // Öneriler - liste adının hemen altında
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
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Oluştur butonu
                Button(action: createList) {
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
            .navigationTitle("Yeni Liste Oluştur")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        selectedTab = 0
                    }
                }
            }
        }
    }
    
    private func createList() {
        guard !listName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        viewModel.addNewList(name: listName)
        selectedTab = 0 // Ana sayfaya dön
    }
    
    private let suggestedLists = [
        "Market Alışverişi",
        "Haftalık Alışveriş",
        "Kırtasiye",
        "Ev İhtiyaçları",
        "Piknik"
    ]
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
