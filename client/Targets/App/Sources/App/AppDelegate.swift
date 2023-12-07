import UIKit
import Combine
import CoreKit
import FoundationKit
import DataRepositories
import NMapsMap
import ModernRIBs
import Firebase
import FirebaseMessaging
import DomainUseCases
import NetworkAPIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    private lazy var appUseCase = makeAppUseCase()
    private var cancellables = Set<AnyCancellable>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appSetup()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let router = makeRootBuilder().build()
        self.launchRouter = router
        launchRouter?.launch(from: window)
        return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let code = url.absoluteString.components(separatedBy: "code=").last {
            GithubLoginRepository.shared.requestToken(with: code)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        appUseCase.register(deviceToken: deviceToken)
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        appUseCase.updateToken()
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.noData)
    }
    
}

private extension AppDelegate {
    
    func appSetup() {
        NMFAuthManager.shared().clientId = Secret.naverMapClientID.value
        setupFirebase()
        setupFirebaseMessaging()
        receiveSignOut()
    }
    
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
    
    func setupFirebaseMessaging() {
        Messaging.messaging().delegate = self
    }
    
    func setupFirebase() {
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
           let options = FirebaseOptions(contentsOfFile: path) {
            FirebaseApp.configure(options: options)
        } else {
            FirebaseApp.configure()
        }
    }
    
    func setupNotification() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func makeAppUseCase() -> AppUseCase {
        return AppUseCase(
            service: AppService(session: NetworkProvider(
                session: URLSession.shared,
                signOutService: SignoutService.shared
            )),
            pushService: PushService.shared
        )
    }
    
}
