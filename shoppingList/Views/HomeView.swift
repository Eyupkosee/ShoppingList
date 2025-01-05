//
//  HomeView.swift
//  shoppingList
//
//  Created by eyüp köse on 6.01.2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @State private var showingNewListSheet = false
    @State private var listToDelete: ShoppingList? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.shoppingLists.isEmpty {
                    EmptyStateView(showNewListSheet: $showingNewListSheet)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(viewModel.shoppingLists) { list in
                                NavigationLink(
                                    destination: ListDetailView(
                                        viewModel: viewModel.createListDetailViewModel(for: list)
                                    )
                                ) {
                                    ListCardView(list: list)
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                listToDelete = list
                                            } label: {
                                                Label("Sil", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Alışveriş Listeleri")
        }
        .alert("Listeyi Sil", isPresented: .init(
            get: { listToDelete != nil },
            set: { if !$0 { listToDelete = nil } }
        )) {
            Button("İptal", role: .cancel) {
                listToDelete = nil
            }
            Button("Sil", role: .destructive) {
                if let list = listToDelete,
                   let index = viewModel.shoppingLists.firstIndex(where: { $0.id == list.id }) {
                    viewModel.deleteList(at: IndexSet(integer: index))
                }
                listToDelete = nil
            }
        } message: {
            if let list = listToDelete {
                Text("\(list.name) listesini silmek istediğinize emin misiniz?")
            }
        }
    }
}

// Boş durum görünümü
private struct EmptyStateView: View {
    @Binding var showNewListSheet: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "cart.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue.opacity(0.8))
            
            VStack(spacing: 8) {
                Text("Alışveriş Listesi Yok")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("İlk alışveriş listenizi oluşturarak başlayın")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                showNewListSheet = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Yeni Liste Oluştur")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

// Liste kart görünümü
private struct ListCardView: View {
    let list: ShoppingList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(list.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("\(list.items.count) ürün")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                CircularProgressView(
                    completed: list.items.filter { $0.isCompleted }.count,
                    total: list.items.count
                )
            }
            
            if !list.items.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 8) {
                        ForEach(list.items.prefix(4)) { item in
                            ItemBadge(name: item.name, isCompleted: item.isCompleted)
                        }
                        if list.items.count > 4 {
                            Text("+\(list.items.count - 4)")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Dairesel ilerleme göstergesi
private struct CircularProgressView: View {
    let completed: Int
    let total: Int
    
    private var progress: Double {
        guard total > 0 else { return 0 }
        return Double(completed) / Double(total)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 4)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            Text("\(Int(progress * 100))%")
                .font(.caption2)
                .fontWeight(.medium)
        }
        .frame(width: 40, height: 40)
    }
}

// Ürün rozeti
private struct ItemBadge: View {
    let name: String
    let isCompleted: Bool
    
    var body: some View {
        Text(name)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isCompleted ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
            .foregroundColor(isCompleted ? .green : .primary)
            .cornerRadius(8)
    }
}

#Preview {
    HomeView(viewModel: ShoppingListViewModel())
}
