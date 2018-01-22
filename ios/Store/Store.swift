import Foundation

import RxSwift

class Store {
    let bag = DisposeBag()
    let state$: BehaviorSubject<State>
    let action$: BehaviorSubject<Actionable>
    
    func dispatch(_ action: Actionable) {
        print("Dispatching action \(action.description)")
        self.action$.onNext(action)
    }
    
    init(_ initialState: State) {
        
        state$ = BehaviorSubject<State>(value: initialState)
        action$ = BehaviorSubject<Actionable>(value: InitialAction())
        let globalShchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        
        action$
            .subscribeOn(globalShchedular)
            .withLatestFrom(state$) { action, state in return (action, state)}
            .subscribe(onNext: { (action, state) in
                if let nextState = State.init(current: state, action: action) {
                    self.state$.onNext(nextState)
                    
                    // TODO: temporary until effects are implemented!!!!!!!!!!
                    if action.type == Action.updatePathAction || action.type == Action.presentMenu {
                        if let rootView = UIApplication.shared.keyWindow?.rootViewController as? RootViewController {
                            Presenter.present(nextState, on: rootView, injecting: self)
                        }
                    }
                    // !!!!!!!!!!!!
                }
                
            }).disposed(by: bag)
    }
}

