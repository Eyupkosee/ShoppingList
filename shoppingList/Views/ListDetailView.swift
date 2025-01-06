import SwiftUI

struct ListDetailView: View {
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var showingAddItem = false
    
    var body: some View {
        List {
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
        .toolbar {
            Button(action: { showingAddItem = true }) {
                Image(systemName: "plus")
            }
        }
        .navigationTitle(viewModel.list.name)
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
                    .foregroundColor(item.isCompleted ? .green : .gray)
                Text(item.name)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                Spacer()
            }
        }
    }
} 