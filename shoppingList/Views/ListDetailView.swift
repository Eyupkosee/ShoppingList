import SwiftUI

struct ListDetailView: View {
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var showingAddItem = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.1),
                    Color.mint.opacity(0.1),
                    Color.teal.opacity(0.1)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.list.items) { item in
                        ItemRow(item: item, onToggle: {
                            viewModel.toggleItem(item)
                        })
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                if let index = viewModel.list.items.firstIndex(where: { $0.id == item.id }) {
                                    viewModel.deleteItems(at: IndexSet([index]))
                                }
                            } label: {
                                Label("Sil", systemImage: "trash")
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.list.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.theme.mintPrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color.theme.mintPrimary)
                        Text("Geri")
                            .foregroundColor(Color.theme.mintPrimary)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: PDFPreviewView(viewModel: viewModel)) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.theme.mintPrimary)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddItem = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Ürün Ekle")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(20)
                }
            }
        }
        .sheet(isPresented: $showingAddItem) {
            AddItemView(viewModel: viewModel)
        }
    }
}

struct ItemRow: View {
    let item: ShoppingItem
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .blue : .gray)
                    .font(.title2)
                
                Text(item.name)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                    .font(.body)
                
                Spacer()
                
                if item.isCompleted {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(6)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white,
                        item.isCompleted ? Color.blue.opacity(0.05) : Color.white
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        item.isCompleted ? 
                        Color.blue.opacity(0.3) : 
                        Color.gray.opacity(0.1),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: item.isCompleted ? 
                Color.blue.opacity(0.1) : 
                Color.black.opacity(0.02),
                radius: 5,
                x: 0,
                y: 2
            )
        }
    }
} 