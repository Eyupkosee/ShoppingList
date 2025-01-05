import SwiftUI

struct ListDetailView: View {
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var newItemName = ""
    
    var body: some View {
        List {
            Section {
                HStack {
                    TextField("Yeni ürün ekle", text: $newItemName)
                    Button("Ekle") {
                        viewModel.addItem(name: newItemName)
                        newItemName = ""
                    }
                    .disabled(newItemName.isEmpty)
                }
            }
            
            ForEach(viewModel.list.items) { item in
                HStack {
                    Text(item.name)
                        .strikethrough(item.isCompleted)
                    Spacer()
                    Button(action: {
                        viewModel.toggleItemCompletion(item: item)
                    }) {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(item.isCompleted ? .green : .gray)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.deleteItem(at: indexSet)
            }
        }
        .navigationTitle(viewModel.list.name)
    }
} 