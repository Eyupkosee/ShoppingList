import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var sharedViewModel = ShoppingListViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: sharedViewModel)
                .tabItem {
                    Label("Anasayfa", systemImage: "house.fill")
                }
                .tag(0)
            
            CreateListView(viewModel: sharedViewModel, selectedTab: $selectedTab)
                .tabItem {
                    Label("Liste Oluştur", systemImage: "plus.circle.fill")
                }
                .tag(1)
        }
    }
} 