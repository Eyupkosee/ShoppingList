import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Uygulamayı zorla light modda çalıştır
        window?.overrideUserInterfaceStyle = .light
        
        // Ekran görüntüsü almayı engelle
        NotificationCenter.default.addObserver(
            forName: UIScreen.capturedDidChangeNotification,
            object: nil,
            queue: .main) { _ in
                if UIScreen.main.isCaptured {
                    // Ekran görüntüsü alındığında kullanıcıyı bilgilendir
                    self.showScreenshotAlert()
                }
        }
        
        // Mevcut scene ayarları...
    }
    
    private func showScreenshotAlert() {
        let alert = UIAlertController(title: "Uyarı", message: "Ekran görüntüsü alındı.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    // Uygulama aktif olduğunda çağrılır
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Ekran görüntüsü ve kayıt engellemeyi yeniden aktifleştir
        window?.isHidden = UIScreen.main.isCaptured
    }
}

// UIWindow extension'ı ekle
extension UIWindow {
    func makeSecure() {
        let field = UITextField()
        field.isSecureTextEntry = true
        self.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layer.superlayer?.allowsGroupOpacity = false
        field.layer.opacity = 0.01
    }
} 
