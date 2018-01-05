import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let bag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func fetchAdaptations() {
        
        AdaptationService().asObservable() // TODO: Sort dependency injection and retrieve singleton from injector
            .subscribe(onNext: { serviceResponse in
                print("Received \(serviceResponse.actions.count) actions")
                store.state$.onNext(adaptedState) // TODO: once reduce is implemented, dispatch actions to store instead of this
            })
            .disposed(by: bag)
    }
    
    func rootViewDidLoad() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in // TODO: subscribeOn instead of this?
            guard let strongSelf = self else { return }
            strongSelf.fetchAdaptations()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
        withTopmost(self.window!.rootViewController!) {
            let mask = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
            $0.present(mask, animated: false, completion: nil)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        withTopmost(self.window!.rootViewController!) {
            $0.dismiss(animated: false, completion: nil)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func withTopmost(_ viewController: UIViewController, _ callback: (_ viewController: UIViewController)->Void) {
        let presented = viewController.presentedViewController
        if(presented != nil) {
            withTopmost(presented!, callback)
        } else {
            callback(viewController)
        }
    }


}

