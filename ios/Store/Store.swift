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
        
        action$ // TODO: off main thread!
            .subscribeOn(globalShchedular)
            .withLatestFrom(state$) { action, state in return (action, state)}
            .subscribe(onNext: { (action, state) in
                print("Reducing action: \(action)")
                if let _ = State.init(old: state, action: action) {
                    print("Push new state")
                }
            }).disposed(by: bag)
    }
}

