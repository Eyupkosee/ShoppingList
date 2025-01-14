import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                     to: nil,
                                     from: nil,
                                     for: nil)
    }
}
#endif

struct ListDetailView: View {
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var searchText = ""
    @State private var showingAddItem = false
    @State private var showingPDFPreview = false
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isSearchFocused: Bool
    
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
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack(spacing: 0) {
                // Özel arama çubuğu
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        TextField("Ürün ara", text: $searchText)
                            .autocapitalization(.none)
                            .focused($isSearchFocused)
                        
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
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredItems) { item in
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    
    private func hideKeyboard() {
        isSearchFocused = false
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