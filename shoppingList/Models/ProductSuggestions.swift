import Foundation

enum SupportedLanguage: String {
    case english = "en"
    case turkish = "tr"
    case german = "de"
    case italian = "it"
    case japanese = "ja"
    case korean = "ko"
    case spanish = "es"
    
    static func current() -> SupportedLanguage {
        let languageCode = Locale.preferredLanguages.first?.prefix(2).lowercased() ?? "en"
        switch languageCode {
        case "tr":
            return .turkish
        case "de":
            return .german
        case "it":
            return .italian
        case "ja":
            return .japanese
        case "ko":
            return .korean
        case "es":
            return .spanish
        default:
            return .english
        }
    }
}

struct ProductSuggestions {
    static func getSuggestions(for language: SupportedLanguage) -> [ProductItem] {
        switch language {
        case .english:
            return english
        case .turkish:
            return turkish
        case .german:
            return german
        case .italian:
            return italian
        case .japanese:
            return japanese
        case .korean:
            return korean
        case .spanish:
            return spanish
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
    
    private static let german: [ProductItem] = [
        // Getränke (İçecekler)
        ProductItem(name: "Wasser", category: .beverages),
        ProductItem(name: "Milch", category: .beverages),
        ProductItem(name: "Kaffee", category: .beverages),
        ProductItem(name: "Tee", category: .beverages),
        ProductItem(name: "Orangensaft", category: .beverages),
        ProductItem(name: "Limonade", category: .beverages),
        ProductItem(name: "Mineralwasser", category: .beverages),
        ProductItem(name: "Eistee", category: .beverages),
        ProductItem(name: "Apfelsaft", category: .beverages),
        ProductItem(name: "Sprudelwasser", category: .beverages),
        
        // Obst (Meyveler)
        ProductItem(name: "Apfel", category: .fruits),
        ProductItem(name: "Banane", category: .fruits),
        ProductItem(name: "Orange", category: .fruits),
        ProductItem(name: "Weintraube", category: .fruits),
        ProductItem(name: "Erdbeere", category: .fruits),
        ProductItem(name: "Ananas", category: .fruits),
        ProductItem(name: "Mango", category: .fruits),
        ProductItem(name: "Pfirsich", category: .fruits),
        ProductItem(name: "Birne", category: .fruits),
        ProductItem(name: "Heidelbeere", category: .fruits),
        
        // Gemüse (Sebzeler)
        ProductItem(name: "Tomate", category: .vegetables),
        ProductItem(name: "Kartoffel", category: .vegetables),
        ProductItem(name: "Zwiebel", category: .vegetables),
        ProductItem(name: "Gurke", category: .vegetables),
        ProductItem(name: "Karotte", category: .vegetables),
        ProductItem(name: "Brokkoli", category: .vegetables),
        ProductItem(name: "Spinat", category: .vegetables),
        ProductItem(name: "Salat", category: .vegetables),
        ProductItem(name: "Paprika", category: .vegetables),
        ProductItem(name: "Pilze", category: .vegetables),
        
        // Milchprodukte (Süt Ürünleri)
        ProductItem(name: "Käse", category: .dairy),
        ProductItem(name: "Joghurt", category: .dairy),
        ProductItem(name: "Butter", category: .dairy),
        ProductItem(name: "Frischkäse", category: .dairy),
        ProductItem(name: "Mozzarella", category: .dairy),
        ProductItem(name: "Sahne", category: .dairy),
        ProductItem(name: "Quark", category: .dairy),
        
        // Grundnahrungsmittel (Temel Gıdalar)
        ProductItem(name: "Brot", category: .basicFoods),
        ProductItem(name: "Reis", category: .basicFoods),
        ProductItem(name: "Nudeln", category: .basicFoods),
        ProductItem(name: "Mehl", category: .basicFoods),
        ProductItem(name: "Zucker", category: .basicFoods),
        ProductItem(name: "Salz", category: .basicFoods),
        ProductItem(name: "Olivenöl", category: .basicFoods),
        
        // Fleisch und Protein (Et ve Protein)
        ProductItem(name: "Hähnchen", category: .meatAndProtein),
        ProductItem(name: "Hackfleisch", category: .meatAndProtein),
        ProductItem(name: "Fisch", category: .meatAndProtein),
        ProductItem(name: "Eier", category: .meatAndProtein),
        ProductItem(name: "Pute", category: .meatAndProtein),
        
        // Snacks (Atıştırmalıklar)
        ProductItem(name: "Chips", category: .snacks),
        ProductItem(name: "Schokolade", category: .snacks),
        ProductItem(name: "Kekse", category: .snacks),
        ProductItem(name: "Nüsse", category: .snacks),
        ProductItem(name: "Popcorn", category: .snacks),
        
        // Reinigung (Temizlik)
        ProductItem(name: "Waschmittel", category: .cleaning),
        ProductItem(name: "Spülmittel", category: .cleaning),
        ProductItem(name: "Bleichmittel", category: .cleaning),
        ProductItem(name: "Papiertücher", category: .cleaning),
        ProductItem(name: "Müllbeutel", category: .cleaning),
        
        // Körperpflege (Kişisel Bakım)
        ProductItem(name: "Shampoo", category: .personalCare),
        ProductItem(name: "Zahnpasta", category: .personalCare),
        ProductItem(name: "Seife", category: .personalCare),
        ProductItem(name: "Toilettenpapier", category: .personalCare),
        ProductItem(name: "Feuchttücher", category: .personalCare),
        ProductItem(name: "Duschgel", category: .personalCare),
        ProductItem(name: "Deodorant", category: .personalCare)
    ]
    
    private static let italian: [ProductItem] = [
        // Bevande (İçecekler)
        ProductItem(name: "Acqua", category: .beverages),
        ProductItem(name: "Latte", category: .beverages),
        ProductItem(name: "Caffè", category: .beverages),
        ProductItem(name: "Tè", category: .beverages),
        ProductItem(name: "Succo d'Arancia", category: .beverages),
        ProductItem(name: "Limonata", category: .beverages),
        ProductItem(name: "Acqua Minerale", category: .beverages),
        ProductItem(name: "Tè Freddo", category: .beverages),
        ProductItem(name: "Succo di Mela", category: .beverages),
        ProductItem(name: "Acqua Frizzante", category: .beverages),
        
        // Frutta (Meyveler)
        ProductItem(name: "Mela", category: .fruits),
        ProductItem(name: "Banana", category: .fruits),
        ProductItem(name: "Arancia", category: .fruits),
        ProductItem(name: "Uva", category: .fruits),
        ProductItem(name: "Fragola", category: .fruits),
        ProductItem(name: "Ananas", category: .fruits),
        ProductItem(name: "Mango", category: .fruits),
        ProductItem(name: "Pesca", category: .fruits),
        ProductItem(name: "Pera", category: .fruits),
        ProductItem(name: "Mirtillo", category: .fruits),
        
        // Verdura (Sebzeler)
        ProductItem(name: "Pomodoro", category: .vegetables),
        ProductItem(name: "Patata", category: .vegetables),
        ProductItem(name: "Cipolla", category: .vegetables),
        ProductItem(name: "Cetriolo", category: .vegetables),
        ProductItem(name: "Carota", category: .vegetables),
        ProductItem(name: "Broccoli", category: .vegetables),
        ProductItem(name: "Spinaci", category: .vegetables),
        ProductItem(name: "Lattuga", category: .vegetables),
        ProductItem(name: "Peperone", category: .vegetables),
        ProductItem(name: "Funghi", category: .vegetables),
        
        // Latticini (Süt Ürünleri)
        ProductItem(name: "Formaggio", category: .dairy),
        ProductItem(name: "Yogurt", category: .dairy),
        ProductItem(name: "Burro", category: .dairy),
        ProductItem(name: "Ricotta", category: .dairy),
        ProductItem(name: "Mozzarella", category: .dairy),
        ProductItem(name: "Panna", category: .dairy),
        ProductItem(name: "Mascarpone", category: .dairy),
        
        // Alimenti Base (Temel Gıdalar)
        ProductItem(name: "Pane", category: .basicFoods),
        ProductItem(name: "Riso", category: .basicFoods),
        ProductItem(name: "Pasta", category: .basicFoods),
        ProductItem(name: "Farina", category: .basicFoods),
        ProductItem(name: "Zucchero", category: .basicFoods),
        ProductItem(name: "Sale", category: .basicFoods),
        ProductItem(name: "Olio d'Oliva", category: .basicFoods),
        
        // Carne e Proteine (Et ve Protein)
        ProductItem(name: "Pollo", category: .meatAndProtein),
        ProductItem(name: "Carne Macinata", category: .meatAndProtein),
        ProductItem(name: "Pesce", category: .meatAndProtein),
        ProductItem(name: "Uova", category: .meatAndProtein),
        ProductItem(name: "Tacchino", category: .meatAndProtein),
        
        // Snack (Atıştırmalıklar)
        ProductItem(name: "Patatine", category: .snacks),
        ProductItem(name: "Cioccolato", category: .snacks),
        ProductItem(name: "Biscotti", category: .snacks),
        ProductItem(name: "Frutta Secca", category: .snacks),
        ProductItem(name: "Pop Corn", category: .snacks),
        
        // Pulizia (Temizlik)
        ProductItem(name: "Detersivo", category: .cleaning),
        ProductItem(name: "Detersivo per Piatti", category: .cleaning),
        ProductItem(name: "Candeggina", category: .cleaning),
        ProductItem(name: "Carta Assorbente", category: .cleaning),
        ProductItem(name: "Sacchetti Spazzatura", category: .cleaning),
        
        // Cura Personale (Kişisel Bakım)
        ProductItem(name: "Shampoo", category: .personalCare),
        ProductItem(name: "Dentifricio", category: .personalCare),
        ProductItem(name: "Sapone", category: .personalCare),
        ProductItem(name: "Carta Igienica", category: .personalCare),
        ProductItem(name: "Salviette Umidificate", category: .personalCare),
        ProductItem(name: "Bagnoschiuma", category: .personalCare),
        ProductItem(name: "Deodorante", category: .personalCare)
    ]
    
    private static let japanese: [ProductItem] = [
        // 飲み物 (Nomimono - İçecekler)
        ProductItem(name: "水", category: .beverages),              // Mizu
        ProductItem(name: "牛乳", category: .beverages),            // Gyūnyū
        ProductItem(name: "コーヒー", category: .beverages),         // Kōhī
        ProductItem(name: "お茶", category: .beverages),            // Ocha
        ProductItem(name: "オレンジジュース", category: .beverages),    // Orenji jūsu
        ProductItem(name: "緑茶", category: .beverages),            // Ryokucha
        ProductItem(name: "ミネラルウォーター", category: .beverages),   // Mineraru wōtā
        ProductItem(name: "炭酸水", category: .beverages),           // Tansan sui
        
        // 果物 (Kudamono - Meyveler)
        ProductItem(name: "りんご", category: .fruits),              // Ringo
        ProductItem(name: "バナナ", category: .fruits),              // Banana
        ProductItem(name: "みかん", category: .fruits),              // Mikan
        ProductItem(name: "ぶどう", category: .fruits),              // Budō
        ProductItem(name: "いちご", category: .fruits),              // Ichigo
        ProductItem(name: "パイナップル", category: .fruits),          // Painappuru
        ProductItem(name: "もも", category: .fruits),               // Momo
        ProductItem(name: "なし", category: .fruits),               // Nashi
        
        // 野菜 (Yasai - Sebzeler)
        ProductItem(name: "トマト", category: .vegetables),           // Tomato
        ProductItem(name: "じゃがいも", category: .vegetables),        // Jagaimo
        ProductItem(name: "玉ねぎ", category: .vegetables),          // Tamanegi
        ProductItem(name: "きゅうり", category: .vegetables),         // Kyūri
        ProductItem(name: "にんじん", category: .vegetables),         // Ninjin
        ProductItem(name: "ブロッコリー", category: .vegetables),      // Burokkorī
        ProductItem(name: "ほうれん草", category: .vegetables),       // Hōrensō
        ProductItem(name: "レタス", category: .vegetables),          // Retasu
        
        // 乳製品 (Nyūseihin - Süt Ürünleri)
        ProductItem(name: "チーズ", category: .dairy),              // Chīzu
        ProductItem(name: "ヨーグルト", category: .dairy),           // Yōguruto
        ProductItem(name: "バター", category: .dairy),              // Batā
        ProductItem(name: "生クリーム", category: .dairy),           // Nama kurīmu
        
        // 基本食品 (Kihon Shokuhin - Temel Gıdalar)
        ProductItem(name: "お米", category: .basicFoods),           // Okome
        ProductItem(name: "パン", category: .basicFoods),           // Pan
        ProductItem(name: "麺", category: .basicFoods),            // Men
        ProductItem(name: "小麦粉", category: .basicFoods),         // Komugiko
        ProductItem(name: "砂糖", category: .basicFoods),          // Satō
        ProductItem(name: "塩", category: .basicFoods),            // Shio
        ProductItem(name: "醤油", category: .basicFoods),          // Shōyu
        ProductItem(name: "味噌", category: .basicFoods),          // Miso
        
        // 肉・タンパク質 (Niku/Tanpakushitsu - Et ve Protein)
        ProductItem(name: "鶏肉", category: .meatAndProtein),       // Toriniku
        ProductItem(name: "牛肉", category: .meatAndProtein),       // Gyūniku
        ProductItem(name: "魚", category: .meatAndProtein),        // Sakana
        ProductItem(name: "卵", category: .meatAndProtein),        // Tamago
        ProductItem(name: "豆腐", category: .meatAndProtein),       // Tōfu
        
        // お菓子 (Okashi - Atıştırmalıklar)
        ProductItem(name: "ポテトチップス", category: .snacks),        // Poteto chippusu
        ProductItem(name: "チョコレート", category: .snacks),         // Chokorēto
        ProductItem(name: "せんべい", category: .snacks),            // Senbei
        ProductItem(name: "ポップコーン", category: .snacks),         // Poppukōn
        
        // 掃除用品 (Sōji Yōhin - Temizlik)
        ProductItem(name: "洗剤", category: .cleaning),             // Senzai
        ProductItem(name: "食器用洗剤", category: .cleaning),        // Shokki-yō senzai
        ProductItem(name: "漂白剤", category: .cleaning),           // Hyōhakuzai
        ProductItem(name: "ゴミ袋", category: .cleaning),           // Gomi bukuro
        
        // 個人用品 (Kojin Yōhin - Kişisel Bakım)
        ProductItem(name: "シャンプー", category: .personalCare),     // Shanpū
        ProductItem(name: "歯磨き粉", category: .personalCare),      // Hamigakiko
        ProductItem(name: "石鹸", category: .personalCare),         // Sekken
        ProductItem(name: "トイレットペーパー", category: .personalCare), // Toiretto pēpā
        ProductItem(name: "ボディーソープ", category: .personalCare),   // Bodī sōpu
        ProductItem(name: "デオドラント", category: .personalCare)     // Deodoranto
    ]
    
    private static let korean: [ProductItem] = [
        // 음료 (Eumryo - İçecekler)
        ProductItem(name: "물", category: .beverages),              // Mul
        ProductItem(name: "우유", category: .beverages),            // Uyu
        ProductItem(name: "커피", category: .beverages),            // Keopi
        ProductItem(name: "차", category: .beverages),              // Cha
        ProductItem(name: "오렌지 주스", category: .beverages),       // Orenji juseu
        ProductItem(name: "녹차", category: .beverages),            // Nokcha
        ProductItem(name: "생수", category: .beverages),            // Saengsu
        ProductItem(name: "탄산수", category: .beverages),           // Tansansu
        
        // 과일 (Gwail - Meyveler)
        ProductItem(name: "사과", category: .fruits),               // Sagwa
        ProductItem(name: "바나나", category: .fruits),             // Banana
        ProductItem(name: "귤", category: .fruits),                // Gyul
        ProductItem(name: "포도", category: .fruits),               // Podo
        ProductItem(name: "딸기", category: .fruits),               // Ttalgi
        ProductItem(name: "파인애플", category: .fruits),            // Painaepeul
        ProductItem(name: "복숭아", category: .fruits),             // Boksunga
        ProductItem(name: "배", category: .fruits),                // Bae
        
        // 채소 (Chaeso - Sebzeler)
        ProductItem(name: "토마토", category: .vegetables),          // Tomato
        ProductItem(name: "감자", category: .vegetables),           // Gamja
        ProductItem(name: "양파", category: .vegetables),           // Yangpa
        ProductItem(name: "오이", category: .vegetables),           // Oi
        ProductItem(name: "당근", category: .vegetables),           // Danggeun
        ProductItem(name: "브로콜리", category: .vegetables),        // Beurokoli
        ProductItem(name: "시금치", category: .vegetables),          // Sigeumchi
        ProductItem(name: "상추", category: .vegetables),           // Sangchu
        
        // 유제품 (Yujepum - Süt Ürünleri)
        ProductItem(name: "치즈", category: .dairy),               // Chijeu
        ProductItem(name: "요구르트", category: .dairy),            // Yogureuteu
        ProductItem(name: "버터", category: .dairy),               // Beoteo
        ProductItem(name: "생크림", category: .dairy),              // Saengkeurim
        
        // 기본 식품 (Gibon Sikpum - Temel Gıdalar)
        ProductItem(name: "쌀", category: .basicFoods),            // Ssal
        ProductItem(name: "빵", category: .basicFoods),            // Ppang
        ProductItem(name: "면", category: .basicFoods),            // Myeon
        ProductItem(name: "밀가루", category: .basicFoods),         // Milgaru
        ProductItem(name: "설탕", category: .basicFoods),          // Seoltang
        ProductItem(name: "소금", category: .basicFoods),          // Sogeum
        ProductItem(name: "간장", category: .basicFoods),          // Ganjang
        ProductItem(name: "고추장", category: .basicFoods),         // Gochujang
        ProductItem(name: "된장", category: .basicFoods),          // Doenjang
        
        // 고기/단백질 (Gogi/Danbaekjil - Et ve Protein)
        ProductItem(name: "닭고기", category: .meatAndProtein),     // Dakgogi
        ProductItem(name: "소고기", category: .meatAndProtein),     // Sogogi
        ProductItem(name: "생선", category: .meatAndProtein),      // Saengseon
        ProductItem(name: "계란", category: .meatAndProtein),      // Gyeran
        ProductItem(name: "두부", category: .meatAndProtein),      // Dubu
        
        // 과자 (Gwaja - Atıştırmalıklar)
        ProductItem(name: "감자칩", category: .snacks),            // Gamjachip
        ProductItem(name: "초콜릿", category: .snacks),            // Chokollit
        ProductItem(name: "과자", category: .snacks),              // Gwaja
        ProductItem(name: "팝콘", category: .snacks),              // Papkon
        ProductItem(name: "김", category: .snacks),               // Gim
        
        // 청소용품 (Cheongso-yongpum - Temizlik)
        ProductItem(name: "세제", category: .cleaning),            // Seje
        ProductItem(name: "주방세제", category: .cleaning),         // Jubang seje
        ProductItem(name: "표백제", category: .cleaning),          // Pyobaekje
        ProductItem(name: "쓰레기봉투", category: .cleaning),       // Sseuregi bongtu
        
        // 개인용품 (Gaein-yongpum - Kişisel Bakım)
        ProductItem(name: "샴푸", category: .personalCare),        // Syampu
        ProductItem(name: "치약", category: .personalCare),        // Chiyak
        ProductItem(name: "비누", category: .personalCare),        // Binu
        ProductItem(name: "화장지", category: .personalCare),       // Hwajangji
        ProductItem(name: "바디워시", category: .personalCare),      // Badiwosi
        ProductItem(name: "데오도란트", category: .personalCare)     // Deodoranteu
    ]
    
    private static let spanish: [ProductItem] = [
        // Bebidas (İçecekler)
        ProductItem(name: "Agua", category: .beverages),
        ProductItem(name: "Leche", category: .beverages),
        ProductItem(name: "Café", category: .beverages),
        ProductItem(name: "Té", category: .beverages),
        ProductItem(name: "Jugo de Naranja", category: .beverages),
        ProductItem(name: "Limonada", category: .beverages),
        ProductItem(name: "Agua Mineral", category: .beverages),
        ProductItem(name: "Té Helado", category: .beverages),
        ProductItem(name: "Jugo de Manzana", category: .beverages),
        ProductItem(name: "Agua con Gas", category: .beverages),
        
        // Frutas (Meyveler)
        ProductItem(name: "Manzana", category: .fruits),
        ProductItem(name: "Plátano", category: .fruits),
        ProductItem(name: "Naranja", category: .fruits),
        ProductItem(name: "Uvas", category: .fruits),
        ProductItem(name: "Fresa", category: .fruits),
        ProductItem(name: "Piña", category: .fruits),
        ProductItem(name: "Mango", category: .fruits),
        ProductItem(name: "Melocotón", category: .fruits),
        ProductItem(name: "Pera", category: .fruits),
        ProductItem(name: "Arándanos", category: .fruits),
        
        // Verduras (Sebzeler)
        ProductItem(name: "Tomate", category: .vegetables),
        ProductItem(name: "Papa", category: .vegetables),
        ProductItem(name: "Cebolla", category: .vegetables),
        ProductItem(name: "Pepino", category: .vegetables),
        ProductItem(name: "Zanahoria", category: .vegetables),
        ProductItem(name: "Brócoli", category: .vegetables),
        ProductItem(name: "Espinacas", category: .vegetables),
        ProductItem(name: "Lechuga", category: .vegetables),
        ProductItem(name: "Pimiento", category: .vegetables),
        ProductItem(name: "Champiñones", category: .vegetables),
        
        // Lácteos (Süt Ürünleri)
        ProductItem(name: "Queso", category: .dairy),
        ProductItem(name: "Yogur", category: .dairy),
        ProductItem(name: "Mantequilla", category: .dairy),
        ProductItem(name: "Queso Crema", category: .dairy),
        ProductItem(name: "Mozzarella", category: .dairy),
        ProductItem(name: "Crema", category: .dairy),
        ProductItem(name: "Requesón", category: .dairy),
        
        // Alimentos Básicos (Temel Gıdalar)
        ProductItem(name: "Pan", category: .basicFoods),
        ProductItem(name: "Arroz", category: .basicFoods),
        ProductItem(name: "Pasta", category: .basicFoods),
        ProductItem(name: "Harina", category: .basicFoods),
        ProductItem(name: "Azúcar", category: .basicFoods),
        ProductItem(name: "Sal", category: .basicFoods),
        ProductItem(name: "Aceite de Oliva", category: .basicFoods),
        ProductItem(name: "Tortillas", category: .basicFoods),
        ProductItem(name: "Frijoles", category: .basicFoods),
        
        // Carne y Proteína (Et ve Protein)
        ProductItem(name: "Pollo", category: .meatAndProtein),
        ProductItem(name: "Carne Molida", category: .meatAndProtein),
        ProductItem(name: "Pescado", category: .meatAndProtein),
        ProductItem(name: "Huevos", category: .meatAndProtein),
        ProductItem(name: "Pavo", category: .meatAndProtein),
        ProductItem(name: "Jamón", category: .meatAndProtein),
        ProductItem(name: "Chorizo", category: .meatAndProtein),
        
        // Aperitivos (Atıştırmalıklar)
        ProductItem(name: "Papas Fritas", category: .snacks),
        ProductItem(name: "Chocolate", category: .snacks),
        ProductItem(name: "Galletas", category: .snacks),
        ProductItem(name: "Frutos Secos", category: .snacks),
        ProductItem(name: "Palomitas", category: .snacks),
        ProductItem(name: "Nachos", category: .snacks),
        ProductItem(name: "Churros", category: .snacks),
        
        // Limpieza (Temizlik)
        ProductItem(name: "Detergente", category: .cleaning),
        ProductItem(name: "Jabón para Platos", category: .cleaning),
        ProductItem(name: "Blanqueador", category: .cleaning),
        ProductItem(name: "Toallas de Papel", category: .cleaning),
        ProductItem(name: "Bolsas de Basura", category: .cleaning),
        ProductItem(name: "Limpiador Multiusos", category: .cleaning),
        
        // Cuidado Personal (Kişisel Bakım)
        ProductItem(name: "Champú", category: .personalCare),
        ProductItem(name: "Pasta de Dientes", category: .personalCare),
        ProductItem(name: "Jabón", category: .personalCare),
        ProductItem(name: "Papel Higiénico", category: .personalCare),
        ProductItem(name: "Toallitas Húmedas", category: .personalCare),
        ProductItem(name: "Gel de Ducha", category: .personalCare),
        ProductItem(name: "Desodorante", category: .personalCare)
    ]
}
