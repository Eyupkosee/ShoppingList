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
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.theme.tabBarBackground)
            
            // TabBar gölgesi kaldırma
            appearance.shadowColor = nil
            
            // Seçili olmayan durum için renk
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.theme.secondaryText)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.secondaryText)]
            
            // Seçili durum için renk
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.blue.opacity(0.7))
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.blue.opacity(0.7))]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    MainTabView()
} 
