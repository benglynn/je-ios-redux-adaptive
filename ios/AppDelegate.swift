import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PresentationDelegate {
    var window: UIWindow?
    private let bag = DisposeBag()
    private let adaptationService = AdaptationService()
    private let store = Store(initialState)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var rootView = UIStoryboard(name: "RootView", bundle: nil).instantiateInitialViewController() as! PresentationRoot & UIViewController
        rootView.presentationDelegate = self
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            window.rootViewController = rootView
            window.makeKeyAndVisible()
        }
        return true
    }

    func readyToPresent(on presentationRoot: PresentationRoot) {
        let globalShchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        adaptationService.asObservable() // `fake: true` on train journeys
            .subscribeOn(globalShchedular)
            .subscribe(onNext: { serviceResponse in
                let actions: [Actionable] = serviceResponse.actions
                    .filter { $0.active == true }
                    .map { Action(rawValue: $0.type) }
                    .filter { $0 != nil }
                    .map { ActivateAdaptationAction(type: $0!) } + [UpdateIsAdaptedAction(isAdapted: true)]
                actions.forEach { self.store.dispatch($0) }
            }).disposed(by: self.bag)
        
        store.state$
            .filter { state in state.core.isAdapted }.take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                presentationRoot.prepareToPresent {
                    self.store.dispatch(UpdatePathAction(path: "")) // TODO: universal link or default to home
                }
            }).disposed(by: bag)
            
    }
}

