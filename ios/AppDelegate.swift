import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let bag = DisposeBag()
    private let adaptationService = AdaptationService()
    private let store = Store(initialState)

    func readyToPresent(on rootView: RootViewController) {
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
                rootView.prepareToPresent {
                    self.store.dispatch(UpdatePathAction(path: "")) // TODO: universal link or default to home
                }
            }).disposed(by: bag)
            
    }
}

