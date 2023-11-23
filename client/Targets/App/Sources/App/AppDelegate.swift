import UIKit
import Combine
import ModernRIBs

import FoundationKit
import NMapsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    private var cancellables = Set<AnyCancellable>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let router = makeRootBuilder().build()
        self.launchRouter = router
        launchRouter?.launch(from: window)
        NMFAuthManager.shared().clientId = Secret.naverMapClientID.value
        receiveSignOut()
        return true
    }
    
}

private extension AppDelegate {
    
    func makeRootBuilder() -> AppRootBuilder {
        return AppRootBuilder(dependency: AppComponent())
    }
    
    func resetAppRoot() {
        guard let window else { return }
        window.rootViewController = nil
        launchRouter = nil
        let router = makeRootBuilder().build()
        self.launchRouter = router
        launchRouter?.launch(from: window)
    }
    
    func receiveSignOut() {
        SignoutService.shared.signOutCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSignOutCompleted in
                guard let self else { return }
                resetAppRoot()
            }
            .store(in: &cancellables)
    }
    
}
