import Foundation

enum SupportedLanguage: String {
    case english = "en"
    case turkish = "tr"
    
    static func current() -> SupportedLanguage {
        // Önce sistem dilini kontrol et
        let languageCode = Locale.preferredLanguages.first?.prefix(2).lowercased() ?? "en"
        
        // Türkçe dil kodlarını kontrol et
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
            return english.map { ProductItem(name: $0) }
        case .turkish:
            return turkish.map { ProductItem(name: $0) }
        }
    }
    
    // İngilizce öneriler
    private static let english = [
        // Beverages (Non-Alcoholic)
        "Water", "Milk", "Coffee", "Tea", "Orange Juice", "Apple Juice", "Grape Juice",
        "Soda", "Cola", "Lemonade", "Ice Tea", "Hot Chocolate", "Energy Drink",
        "Mineral Water", "Green Tea", "Smoothie", "Milkshake", "Ayran",
        
        // Fruits
        "Apple", "Banana", "Orange", "Grape", "Strawberry", "Pear", "Peach",
        "Pineapple", "Mango", "Kiwi", "Plum", "Cherry", "Watermelon", "Melon",
        "Pomegranate", "Fig", "Apricot", "Mandarin", "Lemon", "Lime",
        "Raspberry", "Blackberry", "Blueberry", "Cranberry",
        
        // Vegetables
        "Tomato", "Potato", "Onion", "Carrot", "Cucumber", "Lettuce", "Pepper",
        "Broccoli", "Spinach", "Garlic", "Corn", "Mushroom", "Eggplant", "Celery",
        "Cabbage", "Cauliflower", "Green Beans", "Peas", "Asparagus", "Zucchini",
        "Radish", "Beetroot", "Pumpkin", "Sweet Potato",
        
        // Basic Foods & Grains
        "Bread", "Rice", "Pasta", "Flour", "Sugar", "Salt", "Oil", "Eggs",
        "Cheese", "Butter", "Margarine", "Honey", "Jam", "Peanut Butter",
        "Cereal", "Oatmeal", "Pancake Mix", "Waffle Mix", "Noodles", "Crackers",
        
        // Dairy & Alternatives
        "Yogurt", "Cream", "Milk", "Soy Milk", "Almond Milk", "Coconut Milk",
        "Cottage Cheese", "Cream Cheese", "Mozzarella", "Cheddar", "Swiss Cheese",
        "Ice Cream", "Sour Cream", "Whipped Cream",
        
        // Meat & Protein
        "Chicken", "Turkey", "Fish", "Tuna", "Salmon", "Shrimp",
        "Eggs", "Tofu", "Beans", "Lentils", "Chickpeas",
        
        // Snacks & Sweets
        "Chocolate", "Candy", "Cookies", "Chips", "Popcorn", "Nuts",
        "Dried Fruits", "Granola Bars", "Crackers", "Pretzels",
        "Fruit Snacks", "Rice Cakes", "Trail Mix",
        
        // Baking
        "Flour", "Sugar", "Baking Powder", "Baking Soda", "Vanilla Extract",
        "Cocoa Powder", "Yeast", "Cornstarch", "Food Coloring",
        
        // Condiments & Sauces
        "Ketchup", "Mustard", "Mayonnaise", "Hot Sauce", "Soy Sauce",
        "Olive Oil", "Vinegar", "Salad Dressing", "BBQ Sauce",
        
        // Cleaning Supplies
        "Soap", "Detergent", "Shampoo", "Toothpaste", "Paper Towels",
        "Toilet Paper", "Dish Soap", "Sponges", "Trash Bags",
        "Glass Cleaner", "Floor Cleaner", "Air Freshener",
        
        // Personal Care
        "Toothbrush", "Deodorant", "Lotion", "Sunscreen", "Hand Sanitizer",
        "Tissues", "Cotton Swabs", "Band-Aids", "Vitamins", "Shaving Cream",
        "Hair Brush", "Dental Floss", "Face Wash", "Body Wash", "Hand Soap"
    ].sorted()
    
    // Türkçe öneriler
    private static let turkish = [
        // İçecekler (Alkolsüz)
        "Su", "Süt", "Kahve", "Çay", "Portakal Suyu", "Elma Suyu", "Üzüm Suyu",
        "Soda", "Kola", "Limonata", "Soğuk Çay", "Sıcak Çikolata", "Enerji İçeceği",
        "Maden Suyu", "Yeşil Çay", "Smoothie", "Milkshake", "Ayran",
        
        // Meyveler
        "Elma", "Muz", "Portakal", "Üzüm", "Çilek", "Armut", "Şeftali",
        "Ananas", "Mango", "Kivi", "Erik", "Kiraz", "Karpuz", "Kavun",
        "Nar", "İncir", "Kayısı", "Mandalina", "Limon", "Misket Limonu",
        "Ahududu", "Böğürtlen", "Yaban Mersini", "Kızılcık",
        
        // Sebzeler
        "Domates", "Patates", "Soğan", "Havuç", "Salatalık", "Marul", "Biber",
        "Brokoli", "Ispanak", "Sarımsak", "Mısır", "Mantar", "Patlıcan", "Kereviz",
        "Lahana", "Karnabahar", "Taze Fasulye", "Bezelye", "Kuşkonmaz", "Kabak",
        "Turp", "Pancar", "Balkabağı", "Tatlı Patates",
        
        // Temel Gıdalar & Tahıllar
        "Ekmek", "Pirinç", "Makarna", "Un", "Şeker", "Tuz", "Yağ", "Yumurta",
        "Peynir", "Tereyağı", "Margarin", "Bal", "Reçel", "Fıstık Ezmesi",
        "Mısır Gevreği", "Yulaf", "Krep Karışımı", "Waffle Karışımı", "Erişte", "Kraker",
        
        // Süt Ürünleri & Alternatifleri
        "Yoğurt", "Krema", "Süt", "Soya Sütü", "Badem Sütü", "Hindistan Cevizi Sütü",
        "Lor Peyniri", "Krem Peynir", "Mozarella", "Kaşar Peyniri", "İsviçre Peyniri",
        "Dondurma", "Ekşi Krema", "Krem Şanti",
        
        // Et & Protein
        "Tavuk", "Hindi", "Balık", "Ton Balığı", "Somon", "Karides",
        "Yumurta", "Tofu", "Kuru Fasulye", "Mercimek", "Nohut",
        
        // Atıştırmalıklar & Tatlılar
        "Çikolata", "Şeker", "Kurabiye", "Cips", "Patlamış Mısır", "Kuruyemiş",
        "Kuru Meyveler", "Granola Bar", "Kraker", "Tuzlu Kraker",
        "Meyve Cipsi", "Pirinç Patlağı", "Karışık Kuruyemiş",
        
        // Hamur İşi Malzemeleri
        "Un", "Şeker", "Kabartma Tozu", "Karbonat", "Vanilya",
        "Kakao", "Maya", "Nişasta", "Gıda Boyası",
        
        // Soslar & Çeşniler
        "Ketçap", "Hardal", "Mayonez", "Acı Sos", "Soya Sosu",
        "Zeytinyağı", "Sirke", "Salata Sosu", "Barbekü Sosu",
        
        // Temizlik Malzemeleri
        "Sabun", "Deterjan", "Şampuan", "Diş Macunu", "Kağıt Havlu",
        "Tuvalet Kağıdı", "Bulaşık Deterjanı", "Sünger", "Çöp Poşeti",
        "Cam Temizleyici", "Yer Temizleyici", "Oda Kokusu",
        
        // Kişisel Bakım
        "Diş Fırçası", "Deodorant", "Losyon", "Güneş Kremi", "El Dezenfektanı",
        "Mendil", "Kulak Çubuğu", "Yara Bandı", "Vitaminler", "Tıraş Köpüğü",
        "Saç Fırçası", "Diş İpi", "Yüz Temizleyici", "Duş Jeli", "El Sabunu"
    ].sorted()
}
