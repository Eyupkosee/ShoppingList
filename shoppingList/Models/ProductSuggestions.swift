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
        ProductItem(name: "Limonata", category: .beverages),
        ProductItem(name: "Şalgam Suyu", category: .beverages),
        ProductItem(name: "Soğuk Çay", category: .beverages),
        ProductItem(name: "Gazoz", category: .beverages),
        
        // Meyveler
        ProductItem(name: "Elma", category: .fruits),
        ProductItem(name: "Muz", category: .fruits),
        ProductItem(name: "Portakal", category: .fruits),
        ProductItem(name: "Üzüm", category: .fruits),
        ProductItem(name: "Çilek", category: .fruits),
        ProductItem(name: "Karpuz", category: .fruits),
        ProductItem(name: "Kavun", category: .fruits),
        ProductItem(name: "Şeftali", category: .fruits),
        ProductItem(name: "Armut", category: .fruits),
        ProductItem(name: "Kiraz", category: .fruits),
        ProductItem(name: "Mandalina", category: .fruits),
        ProductItem(name: "Nar", category: .fruits),
        ProductItem(name: "İncir", category: .fruits),
        ProductItem(name: "Kayısı", category: .fruits),
        ProductItem(name: "Ananas", category: .fruits),
        
        // Sebzeler
        ProductItem(name: "Domates", category: .vegetables),
        ProductItem(name: "Patates", category: .vegetables),
        ProductItem(name: "Soğan", category: .vegetables),
        ProductItem(name: "Salatalık", category: .vegetables),
        ProductItem(name: "Biber", category: .vegetables),
        ProductItem(name: "Patlıcan", category: .vegetables),
        ProductItem(name: "Havuç", category: .vegetables),
        ProductItem(name: "Kabak", category: .vegetables),
        ProductItem(name: "Ispanak", category: .vegetables),
        ProductItem(name: "Marul", category: .vegetables),
        ProductItem(name: "Brokoli", category: .vegetables),
        ProductItem(name: "Karnabahar", category: .vegetables),
        ProductItem(name: "Taze Fasulye", category: .vegetables),
        ProductItem(name: "Bezelye", category: .vegetables),
        ProductItem(name: "Lahana", category: .vegetables),
        ProductItem(name: "Pırasa", category: .vegetables),
        
        // Süt Ürünleri
        ProductItem(name: "Peynir", category: .dairy),
        ProductItem(name: "Yoğurt", category: .dairy),
        ProductItem(name: "Tereyağı", category: .dairy),
        ProductItem(name: "Kaşar", category: .dairy),
        ProductItem(name: "Krem Peynir", category: .dairy),
        ProductItem(name: "Beyaz Peynir", category: .dairy),
        ProductItem(name: "Süzme Yoğurt", category: .dairy),
        ProductItem(name: "Kaymak", category: .dairy),
        ProductItem(name: "Lor Peyniri", category: .dairy),
        ProductItem(name: "Ayran", category: .dairy),
        
        // Temel Gıdalar
        ProductItem(name: "Ekmek", category: .basicFoods),
        ProductItem(name: "Pirinç", category: .basicFoods),
        ProductItem(name: "Makarna", category: .basicFoods),
        ProductItem(name: "Un", category: .basicFoods),
        ProductItem(name: "Şeker", category: .basicFoods),
        ProductItem(name: "Tuz", category: .basicFoods),
        ProductItem(name: "Bulgur", category: .basicFoods),
        ProductItem(name: "Mercimek", category: .basicFoods),
        ProductItem(name: "Nohut", category: .basicFoods),
        ProductItem(name: "Fasulye", category: .basicFoods),
        ProductItem(name: "Zeytinyağı", category: .basicFoods),
        ProductItem(name: "Ayçiçek Yağı", category: .basicFoods),
        ProductItem(name: "Sirke", category: .basicFoods),
        ProductItem(name: "Salça", category: .basicFoods),
        
        // Et ve Protein
        ProductItem(name: "Tavuk", category: .meatAndProtein),
        ProductItem(name: "Kıyma", category: .meatAndProtein),
        ProductItem(name: "Balık", category: .meatAndProtein),
        ProductItem(name: "Yumurta", category: .meatAndProtein),
        ProductItem(name: "Hindi", category: .meatAndProtein),
        ProductItem(name: "Kuşbaşı Et", category: .meatAndProtein),
        ProductItem(name: "Ton Balığı", category: .meatAndProtein),
        ProductItem(name: "Sucuk", category: .meatAndProtein),
        ProductItem(name: "Sosis", category: .meatAndProtein),
        
        // Atıştırmalıklar
        ProductItem(name: "Cips", category: .snacks),
        ProductItem(name: "Çikolata", category: .snacks),
        ProductItem(name: "Bisküvi", category: .snacks),
        ProductItem(name: "Kuruyemiş", category: .snacks),
        ProductItem(name: "Kuru Meyve", category: .snacks),
        ProductItem(name: "Kraker", category: .snacks),
        ProductItem(name: "Gofret", category: .snacks),
        ProductItem(name: "Mısır Cipsi", category: .snacks),
        ProductItem(name: "Kurabiye", category: .snacks),
        ProductItem(name: "Leblebi", category: .snacks),
        
        // Temizlik
        ProductItem(name: "Deterjan", category: .cleaning),
        ProductItem(name: "Bulaşık Deterjanı", category: .cleaning),
        ProductItem(name: "Çamaşır Suyu", category: .cleaning),
        ProductItem(name: "Peçete", category: .cleaning),
        ProductItem(name: "Çöp Poşeti", category: .cleaning),
        ProductItem(name: "Yumuşatıcı", category: .cleaning),
        ProductItem(name: "Cam Temizleyici", category: .cleaning),
        ProductItem(name: "Yüzey Temizleyici", category: .cleaning),
        ProductItem(name: "Banyo Temizleyici", category: .cleaning),
        ProductItem(name: "Mutfak Temizleyici", category: .cleaning),
        ProductItem(name: "Temizlik Bezi", category: .cleaning),
        ProductItem(name: "Bulaşık Süngeri", category: .cleaning),
        
        // Kişisel Bakım
        ProductItem(name: "Şampuan", category: .personalCare),
        ProductItem(name: "Diş Macunu", category: .personalCare),
        ProductItem(name: "Sabun", category: .personalCare),
        ProductItem(name: "Tuvalet Kağıdı", category: .personalCare),
        ProductItem(name: "Islak Mendil", category: .personalCare),
        ProductItem(name: "Duş Jeli", category: .personalCare),
        ProductItem(name: "Deodorant", category: .personalCare),
        ProductItem(name: "Diş Fırçası", category: .personalCare),
        ProductItem(name: "Saç Kremi", category: .personalCare),
        ProductItem(name: "El Kremi", category: .personalCare),
        ProductItem(name: "Pamuk", category: .personalCare),
        ProductItem(name: "Kulak Çubuğu", category: .personalCare)
    ]
    
    private static let english: [ProductItem] = [
        // Beverages
        ProductItem(name: "Water", category: .beverages),
        ProductItem(name: "Milk", category: .beverages),
        ProductItem(name: "Coffee", category: .beverages),
        ProductItem(name: "Tea", category: .beverages),
        ProductItem(name: "Orange Juice", category: .beverages),
        ProductItem(name: "Soda", category: .beverages),
        ProductItem(name: "Lemonade", category: .beverages),
        ProductItem(name: "Iced Tea", category: .beverages),
        ProductItem(name: "Apple Juice", category: .beverages),
        ProductItem(name: "Sparkling Water", category: .beverages),
        ProductItem(name: "Green Tea", category: .beverages),
        
        // Fruits
        ProductItem(name: "Apple", category: .fruits),
        ProductItem(name: "Banana", category: .fruits),
        ProductItem(name: "Orange", category: .fruits),
        ProductItem(name: "Grape", category: .fruits),
        ProductItem(name: "Strawberry", category: .fruits),
        ProductItem(name: "Pineapple", category: .fruits),
        ProductItem(name: "Mango", category: .fruits),
        ProductItem(name: "Peach", category: .fruits),
        ProductItem(name: "Pear", category: .fruits),
        ProductItem(name: "Blueberry", category: .fruits),
        ProductItem(name: "Raspberry", category: .fruits),
        ProductItem(name: "Kiwi", category: .fruits),
        ProductItem(name: "Watermelon", category: .fruits),
        ProductItem(name: "Lemon", category: .fruits),
        ProductItem(name: "Lime", category: .fruits),
        
        // Vegetables
        ProductItem(name: "Tomato", category: .vegetables),
        ProductItem(name: "Potato", category: .vegetables),
        ProductItem(name: "Onion", category: .vegetables),
        ProductItem(name: "Cucumber", category: .vegetables),
        ProductItem(name: "Carrot", category: .vegetables),
        ProductItem(name: "Broccoli", category: .vegetables),
        ProductItem(name: "Spinach", category: .vegetables),
        ProductItem(name: "Lettuce", category: .vegetables),
        ProductItem(name: "Bell Pepper", category: .vegetables),
        ProductItem(name: "Mushroom", category: .vegetables),
        ProductItem(name: "Zucchini", category: .vegetables),
        ProductItem(name: "Cauliflower", category: .vegetables),
        ProductItem(name: "Green Beans", category: .vegetables),
        ProductItem(name: "Corn", category: .vegetables),
        ProductItem(name: "Asparagus", category: .vegetables),
        
        // Dairy
        ProductItem(name: "Cheese", category: .dairy),
        ProductItem(name: "Yogurt", category: .dairy),
        ProductItem(name: "Butter", category: .dairy),
        ProductItem(name: "Cream Cheese", category: .dairy),
        ProductItem(name: "Mozzarella", category: .dairy),
        ProductItem(name: "Cheddar", category: .dairy),
        ProductItem(name: "Greek Yogurt", category: .dairy),
        ProductItem(name: "Heavy Cream", category: .dairy),
        ProductItem(name: "Sour Cream", category: .dairy),
        ProductItem(name: "Cottage Cheese", category: .dairy),
        
        // Basic Foods
        ProductItem(name: "Bread", category: .basicFoods),
        ProductItem(name: "Rice", category: .basicFoods),
        ProductItem(name: "Pasta", category: .basicFoods),
        ProductItem(name: "Flour", category: .basicFoods),
        ProductItem(name: "Sugar", category: .basicFoods),
        ProductItem(name: "Salt", category: .basicFoods),
        ProductItem(name: "Olive Oil", category: .basicFoods),
        ProductItem(name: "Vegetable Oil", category: .basicFoods),
        ProductItem(name: "Vinegar", category: .basicFoods),
        ProductItem(name: "Tomato Sauce", category: .basicFoods),
        ProductItem(name: "Cereal", category: .basicFoods),
        ProductItem(name: "Honey", category: .basicFoods),
        ProductItem(name: "Peanut Butter", category: .basicFoods),
        ProductItem(name: "Jam", category: .basicFoods),
        
        // Meat and Protein
        ProductItem(name: "Chicken", category: .meatAndProtein),
        ProductItem(name: "Ground Beef", category: .meatAndProtein),
        ProductItem(name: "Fish", category: .meatAndProtein),
        ProductItem(name: "Eggs", category: .meatAndProtein),
        ProductItem(name: "Turkey", category: .meatAndProtein),
        ProductItem(name: "Salmon", category: .meatAndProtein),
        ProductItem(name: "Tuna", category: .meatAndProtein),
        ProductItem(name: "Shrimp", category: .meatAndProtein),
        ProductItem(name: "Tofu", category: .meatAndProtein),
        ProductItem(name: "Bacon", category: .meatAndProtein),
        
        // Snacks
        ProductItem(name: "Chips", category: .snacks),
        ProductItem(name: "Chocolate", category: .snacks),
        ProductItem(name: "Cookies", category: .snacks),
        ProductItem(name: "Nuts", category: .snacks),
        ProductItem(name: "Popcorn", category: .snacks),
        ProductItem(name: "Crackers", category: .snacks),
        ProductItem(name: "Trail Mix", category: .snacks),
        ProductItem(name: "Dried Fruit", category: .snacks),
        ProductItem(name: "Granola Bars", category: .snacks),
        ProductItem(name: "Pretzels", category: .snacks),
        
        // Cleaning
        ProductItem(name: "Detergent", category: .cleaning),
        ProductItem(name: "Dish Soap", category: .cleaning),
        ProductItem(name: "Bleach", category: .cleaning),
        ProductItem(name: "Paper Towels", category: .cleaning),
        ProductItem(name: "Trash Bags", category: .cleaning),
        ProductItem(name: "Fabric Softener", category: .cleaning),
        ProductItem(name: "Glass Cleaner", category: .cleaning),
        ProductItem(name: "Surface Cleaner", category: .cleaning),
        ProductItem(name: "Bathroom Cleaner", category: .cleaning),
        ProductItem(name: "Kitchen Cleaner", category: .cleaning),
        ProductItem(name: "Cleaning Wipes", category: .cleaning),
        ProductItem(name: "Sponges", category: .cleaning),
        
        // Personal Care
        ProductItem(name: "Shampoo", category: .personalCare),
        ProductItem(name: "Toothpaste", category: .personalCare),
        ProductItem(name: "Soap", category: .personalCare),
        ProductItem(name: "Toilet Paper", category: .personalCare),
        ProductItem(name: "Wet Wipes", category: .personalCare),
        ProductItem(name: "Shower Gel", category: .personalCare),
        ProductItem(name: "Deodorant", category: .personalCare),
        ProductItem(name: "Toothbrush", category: .personalCare),
        ProductItem(name: "Conditioner", category: .personalCare),
        ProductItem(name: "Hand Cream", category: .personalCare),
        ProductItem(name: "Cotton Balls", category: .personalCare),
        ProductItem(name: "Cotton Swabs", category: .personalCare),
        ProductItem(name: "Body Lotion", category: .personalCare),
        ProductItem(name: "Hand Sanitizer", category: .personalCare)
    ]
}
