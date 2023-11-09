import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let appComponent: AppComponent = .init()
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let router = AppRootBuilder(dependency: appComponent).build()
        self.launchRouter = router
        
        launchRouter?.launch(from: window)
        appComponent.naverLoginRepository.setup()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }
}
