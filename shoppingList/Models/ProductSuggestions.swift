import Foundation

enum SupportedLanguage: String {
    case english = "en"
    case turkish = "tr"
    
    static func current() -> SupportedLanguage {
        let languageCode = Locale.preferredLanguages.first?.prefix(2).lowercased() ?? "en"
        if languageCode == "tr" {
            return .turkish
        }
        return .english
    }
}

struct ProductSuggestions {
    static func getSuggestions(for language: SupportedLanguage) -> [ProductItem] {
        switch language {
        case .english:
            return english
        case .turkish:
            return turkish
        }
    }
    
    private static let turkish: [ProductItem] = [
        // İçecekler
        ProductItem(name: "Su", category: .beverages),
        ProductItem(name: "Süt", category: .beverages),
        ProductItem(name: "Kahve", category: .beverages),
        ProductItem(name: "Çay", category: .beverages),
        ProductItem(name: "Portakal Suyu", category: .beverages),
        ProductItem(name: "Ayran", category: .beverages),
        ProductItem(name: "Maden Suyu", category: .beverages),
        
        // Meyveler
        ProductItem(name: "Elma", category: .fruits),
        ProductItem(name: "Muz", category: .fruits),
        ProductItem(name: "Portakal", category: .fruits),
        ProductItem(name: "Üzüm", category: .fruits),
        ProductItem(name: "Çilek", category: .fruits),
        ProductItem(name: "Karpuz", category: .fruits),
        ProductItem(name: "Kavun", category: .fruits),
        
        // Sebzeler
        ProductItem(name: "Domates", category: .vegetables),
        ProductItem(name: "Patates", category: .vegetables),
        ProductItem(name: "Soğan", category: .vegetables),
        ProductItem(name: "Salatalık", category: .vegetables),
        ProductItem(name: "Biber", category: .vegetables),
        ProductItem(name: "Patlıcan", category: .vegetables),
        ProductItem(name: "Havuç", category: .vegetables),
        
        // Süt Ürünleri
        ProductItem(name: "Peynir", category: .dairy),
        ProductItem(name: "Yoğurt", category: .dairy),
        ProductItem(name: "Tereyağı", category: .dairy),
        ProductItem(name: "Kaşar", category: .dairy),
        ProductItem(name: "Krem Peynir", category: .dairy),
        
        // Temel Gıdalar
        ProductItem(name: "Ekmek", category: .basicFoods),
        ProductItem(name: "Pirinç", category: .basicFoods),
        ProductItem(name: "Makarna", category: .basicFoods),
        ProductItem(name: "Un", category: .basicFoods),
        ProductItem(name: "Şeker", category: .basicFoods),
        ProductItem(name: "Tuz", category: .basicFoods),
        
        // Et ve Protein
        ProductItem(name: "Tavuk", category: .meatAndProtein),
        ProductItem(name: "Kıyma", category: .meatAndProtein),
        ProductItem(name: "Balık", category: .meatAndProtein),
        ProductItem(name: "Yumurta", category: .meatAndProtein),
        
        // Atıştırmalıklar
        ProductItem(name: "Cips", category: .snacks),
        ProductItem(name: "Çikolata", category: .snacks),
        ProductItem(name: "Bisküvi", category: .snacks),
        ProductItem(name: "Kuruyemiş", category: .snacks),
        
        // Temizlik
        ProductItem(name: "Deterjan", category: .cleaning),
        ProductItem(name: "Bulaşık Deterjanı", category: .cleaning),
        ProductItem(name: "Çamaşır Suyu", category: .cleaning),
        ProductItem(name: "Peçete", category: .cleaning),
        ProductItem(name: "Çöp Poşeti", category: .cleaning),
        
        // Kişisel Bakım
        ProductItem(name: "Şampuan", category: .personalCare),
        ProductItem(name: "Diş Macunu", category: .personalCare),
        ProductItem(name: "Sabun", category: .personalCare),
        ProductItem(name: "Tuvalet Kağıdı", category: .personalCare),
        ProductItem(name: "Islak Mendil", category: .personalCare)
    ]
    
    private static let english: [ProductItem] = [
        // Beverages
        ProductItem(name: "Water", category: .beverages),
        ProductItem(name: "Milk", category: .beverages),
        ProductItem(name: "Coffee", category: .beverages),
        ProductItem(name: "Tea", category: .beverages),
        ProductItem(name: "Orange Juice", category: .beverages),
        ProductItem(name: "Soda", category: .beverages),
        
        // Fruits
        ProductItem(name: "Apple", category: .fruits),
        ProductItem(name: "Banana", category: .fruits),
        ProductItem(name: "Orange", category: .fruits),
        ProductItem(name: "Grape", category: .fruits),
        ProductItem(name: "Strawberry", category: .fruits),
        
        // Vegetables
        ProductItem(name: "Tomato", category: .vegetables),
        ProductItem(name: "Potato", category: .vegetables),
        ProductItem(name: "Onion", category: .vegetables),
        ProductItem(name: "Cucumber", category: .vegetables),
        ProductItem(name: "Carrot", category: .vegetables),
        
        // Dairy
        ProductItem(name: "Cheese", category: .dairy),
        ProductItem(name: "Yogurt", category: .dairy),
        ProductItem(name: "Butter", category: .dairy),
        
        // Basic Foods
        ProductItem(name: "Bread", category: .basicFoods),
        ProductItem(name: "Rice", category: .basicFoods),
        ProductItem(name: "Pasta", category: .basicFoods),
        ProductItem(name: "Flour", category: .basicFoods),
        
        // Meat and Protein
        ProductItem(name: "Chicken", category: .meatAndProtein),
        ProductItem(name: "Ground Beef", category: .meatAndProtein),
        ProductItem(name: "Fish", category: .meatAndProtein),
        ProductItem(name: "Eggs", category: .meatAndProtein),
        
        // Snacks
        ProductItem(name: "Chips", category: .snacks),
        ProductItem(name: "Chocolate", category: .snacks),
        ProductItem(name: "Cookies", category: .snacks),
        ProductItem(name: "Nuts", category: .snacks),
        
        // Cleaning
        ProductItem(name: "Detergent", category: .cleaning),
        ProductItem(name: "Dish Soap", category: .cleaning),
        ProductItem(name: "Bleach", category: .cleaning),
        ProductItem(name: "Paper Towels", category: .cleaning),
        
        // Personal Care
        ProductItem(name: "Shampoo", category: .personalCare),
        ProductItem(name: "Toothpaste", category: .personalCare),
        ProductItem(name: "Soap", category: .personalCare),
        ProductItem(name: "Toilet Paper", category: .personalCare)
    ]
}
