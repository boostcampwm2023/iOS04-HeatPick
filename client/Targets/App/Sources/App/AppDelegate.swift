import UIKit
import ModernRIBs

import CoreKit
import NMapsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let router = AppRootBuilder(dependency: AppComponent()).build()
        self.launchRouter = router
        
        launchRouter?.launch(from: window)
        
        NMFAuthManager.shared().clientId = Secret.naverMapClientID.value
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }
}
