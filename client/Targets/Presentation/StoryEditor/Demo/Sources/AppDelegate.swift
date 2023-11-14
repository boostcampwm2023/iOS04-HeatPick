import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemPink
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        return true
    }
}
