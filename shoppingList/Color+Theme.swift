import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color(red: 255/255, green: 255/255, blue: 255/255)
    let cardBackground = Color.white
    let primaryText = Color.black
    let secondaryText = Color.gray
    let mintPrimary = Color(red: 129/255, green: 199/255, blue: 132/255)
    let progressBackground = Color.gray.opacity(0.2)
    let progressForeground = Color(red: 129/255, green: 199/255, blue: 132/255)
    let tabBarBackground = Color(red: 173/255, green: 235/255, blue: 179/255)
    let tabbarSelect = Color(red: 79/255, green: 210/255, blue: 93/255)
}

// Hex renk desteği için extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

