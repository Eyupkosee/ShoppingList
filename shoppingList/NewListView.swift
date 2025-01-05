import SwiftUI

struct NewListView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ShoppingListViewModel
    @State private var listName = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Liste Adı", text: $listName)
            }
            .navigationTitle("Yeni Liste")
            .navigationBarItems(
                leading: Button("İptal") {
                    dismiss()
                },
                trailing: Button("Kaydet") {
                    viewModel.addNewList(name: listName)
                    dismiss()
                }
                .disabled(listName.isEmpty)
            )
        }
    }
} 