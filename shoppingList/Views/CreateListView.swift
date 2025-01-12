//
//  CreateListView.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct CreateListView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @State private var listName = ""
    @Binding var selectedTab: Int
    @Environment(\.dismiss) var dismiss
    var onListCreated: ((ShoppingList) -> Void)?
    
    @State private var showPaywall = false
    @State private var isPremiumUser = false
    
    private let suggestions = [
        NSLocalizedString("Market", comment: ""),
        NSLocalizedString("Pazar", comment: ""),
        NSLocalizedString("Piknik", comment: ""),
        NSLocalizedString("Gezi", comment: "")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Üst görsel
                Image(systemName: "cart.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(Color.theme.mintPrimary)
                    .padding(.top, 20)
                
                // Liste adı ve öneriler
                VStack(alignment: .leading, spacing: 8) {
                    Text("Liste Adı")
                        .font(.headline)
                        .foregroundColor(Color.theme.primaryText)
                    
                    TextField("Örn: Market Alışverişi", text: $listName)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.words)
                    
                    // Öneriler
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(suggestions, id: \.self) { suggestion in
                                Button(action: {
                                    listName = suggestion
                                }) {
                                    Text(suggestion)
                                        .font(.subheadline)
                                        .foregroundColor(Color.theme.mintPrimary)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.theme.mintPrimary.opacity(0.1))
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
                    createList()
                }) {
                    Text("Liste Oluştur")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            listName.isEmpty ? Color.gray : Color.theme.mintPrimary
                        )
                        .cornerRadius(15)
                        .shadow(color: (listName.isEmpty ? Color.gray : Color.theme.mintPrimary).opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .disabled(listName.isEmpty)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
            .navigationTitle("Yeni Liste")
        }
        .onAppear {
            checkSubscriptionStatus()
        }
        .sheet(isPresented: $showPaywall) {
            PaywallViewControllerRepresentable()
        }
    }
    
    func createList() {
        if !isPremiumUser && viewModel.shoppingLists.count >= 2 {
            showPaywall = true
            return
        }
        
        if let newList = viewModel.createNewList(name: listName) {
            onListCreated?(newList)
            selectedTab = 0  // TabBar'dan açıldığında ana sayfaya dönmesi için
            dismiss()
        }
    }
    
    private func checkSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
            if let error = error {
                print("Hata: Abonelik durumu kontrol edilirken bir sorun oluştu - \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                isPremiumUser = purchaserInfo?.entitlements.active["premium"] != nil
            }
        }
    }
}

// TextField stili
private struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.theme.cardBackground)
            .cornerRadius(12)
            .foregroundColor(Color.theme.primaryText)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.theme.mintPrimary.opacity(0.3), lineWidth: 1)
            )
    }
}

// UIKit PaywallViewController'ı için SwiftUI wrapper
struct PaywallViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PaywallViewController {
        return PaywallViewController()
    }
    
    func updateUIViewController(_ uiViewController: PaywallViewController, context: Context) {
        // Güncelleme gerekmiyor
    }
}

#Preview {
    CreateListView(
        viewModel: ShoppingListViewModel(),
        selectedTab: .constant(0)
    )
}
