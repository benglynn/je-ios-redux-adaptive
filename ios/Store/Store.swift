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
            .subscribe(onNext: { action, state in
                let latestState: State = {
                    if let updatedState = State.init(current: state, action: action, store: self) {
                        self.state$.onNext(updatedState)
                        return updatedState
                    }
                    return state
                }()
                latestState.callSideEffects(for: action, store: self)
                }
            ).disposed(by: bag)
    }
}

