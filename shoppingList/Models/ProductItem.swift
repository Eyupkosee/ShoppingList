import Foundation
import SwiftUI

struct ProductItem: Identifiable {
    let id = UUID()
    let name: String
    let category: ProductCategory
}

enum ProductCategory: String, CaseIterable {
    case beverages = "category_beverages"
    case fruits = "category_fruits"
    case vegetables = "category_vegetables"
    case dairy = "category_dairy"
    case basicFoods = "category_basic_foods"
    case meatAndProtein = "category_meat_protein"
    case snacks = "category_snacks"
    case cleaning = "category_cleaning"
    case personalCare = "category_personal_care"
    
    var localizedName: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    var icon: String {
        switch self {
        case .beverages: return "cup.and.saucer.fill"
        case .fruits: return "leaf.fill"
        case .vegetables: return "carrot.fill"
        case .dairy: return "drop.fill"
        case .basicFoods: return "basket.fill"
        case .meatAndProtein: return "fork.knife"
        case .snacks: return "birthday.cake.fill"
        case .cleaning: return "bubbles.and.sparkles"
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
