import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let bag = DisposeBag()

    func readyToPresent(on rootView: RootViewController) {
        let adaptationService = AdaptationService()
        let store = Store(initialState)
        let globalShchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        
        adaptationService.asObservable(/*fake: true*/)
            .subscribeOn(globalShchedular)
            .subscribe(onNext: { serviceResponse in
                let actions: [Actionable] = serviceResponse.actions
                    .filter { $0.active == true }
                    .map { Action(rawValue: $0.type) }.filter { $0 != nil }
                    .map { ActivateAdaptation(type: $0!) } + [UpdateIsAdaptedAction(isAdapted: true)]
                actions.forEach { store.dispatch($0) }
            }).disposed(by: self.bag)
        
        store.state$
            .filter { state in state.core.isAdapted }.take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                rootView.prepareToPresent {
                    store.dispatch(UpdatePathAction(path: "")) // TODO: universal link or default to home
                }
            }).disposed(by: bag)
            
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
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

