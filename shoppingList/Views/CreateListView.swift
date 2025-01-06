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
                        HStack(spacing: 12) {
                            ForEach(["Market", "Pazar", "Kırtasiye", "Teknoloji"], id: \.self) { suggestion in
                                Button(action: {
                                    listName = suggestion
                                }) {
                                    Text(suggestion)
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding()
                
                Spacer()
                
                // Oluştur butonu
                Button(action: {
                    viewModel.addNewList(name: listName)
                    selectedTab = 0
                }) {
                    Text("Liste Oluştur")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            listName.isEmpty ?
                            LinearGradient(
                                gradient: Gradient(colors: [.gray, .gray]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ) :
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .disabled(listName.isEmpty)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
            .navigationTitle("Yeni Liste")
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
