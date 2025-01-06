import Foundation
import SwiftUI

struct ProductItem: Identifiable {
    let id = UUID()
    let name: String
    let category: ProductCategory
}

enum ProductCategory: String, CaseIterable {
    case beverages = "İçecekler"
    case fruits = "Meyveler"
    case vegetables = "Sebzeler"
    case dairy = "Süt Ürünleri"
    case basicFoods = "Temel Gıdalar"
    case meatAndProtein = "Et ve Protein"
    case snacks = "Atıştırmalıklar"
    case cleaning = "Temizlik"
    case personalCare = "Kişisel Bakım"
    
    var icon: String {
        switch self {
        case .beverages: return "cup.and.saucer.fill"
        case .fruits: return "leaf.fill"
        case .vegetables: return "carrot.fill"
        case .dairy: return "drop.fill"
        case .basicFoods: return "basket.fill"
        case .meatAndProtein: return "fork.knife"
        case .snacks: return "birthday.cake.fill"
        case .cleaning: return "spray.fill"
        case .personalCare: return "heart.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .beverages: return .blue
        case .fruits: return .green
        case .vegetables: return .orange
        case .dairy: return .cyan
        case .basicFoods: return .brown
        case .meatAndProtein: return .red
        case .snacks: return .purple
        case .cleaning: return .mint
        case .personalCare: return .pink
        }
    }
} 
