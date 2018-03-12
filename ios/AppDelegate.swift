import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let bag = DisposeBag()
    
    /* TODO: composition route and (Dip?) DI container for these and others */
    private let adaptationService = AdaptationService()
    private let store = Store(initialState)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let initialPresenter = InitialPresenter(adaptationService: adaptationService, store: store, initialPath: "bs34sh" /* TODO: Universal links */)
        var rootView = UIStoryboard(name: "RootView", bundle: nil).instantiateInitialViewController() as! PresentationRoot & UIViewController
        rootView.initialPresentationDelegate = initialPresenter
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            window.rootViewController = rootView
            window.makeKeyAndVisible()
        }
        return true
    }
}

