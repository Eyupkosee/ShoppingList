class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Uygulamayı zorla light modda çalıştır
        window?.overrideUserInterfaceStyle = .light
        
        // Mevcut scene ayarları...
    }
} 