import UIKit
import MyInterfaces
import MyImplementations
import ModernRIBs
import CoreKit
import NetworkAPIKit
import BasePresentation
import DomainInterfaces
import DomainUseCases
import DataRepositories

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var launchRouter: DemoRootRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let router = DemoRootBuilder(dependency: DemoRootComponent()).build()
        router.listener = self
        self.launchRouter = router
        router.launch(from: window)
        return true
    }
    
}

extension AppDelegate: DemoRootRouterListener, MyPageListener {
    
    func demoRootRouterDidBecomeActive() {
        launchRouter?.attach(execute: { viewController in
            let router = MyPageBuilder(dependency: MyPageRootComponent()).build(withListener: self)
            viewController.present(NavigationControllable(viewControllable: router.viewControllable), animated: true, isFullScreen: true)
            launchRouter?.attachChild(router)
        })
    }
    
}

final class MyPageRootComponent: MyPageDependency {
    
    
}
