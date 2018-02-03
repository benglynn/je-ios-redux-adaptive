import Foundation
import RxSwift

struct InitialPresenter: InitialPresentationDelegate {
    
    let adaptationService: AdaptationService
    let store: Store
    let initialPath: String
    private let bag = DisposeBag()
    
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
                    self.store.dispatch(UpdatePathAction(path: self.initialPath))
                }
            }
        ).disposed(by: bag)
    }
}
