import UIKit
import HomeImplementations

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let viewController = UIViewController()
        window.rootViewController = HomeViewController()
        window.makeKeyAndVisible()
        return true
    }
}
