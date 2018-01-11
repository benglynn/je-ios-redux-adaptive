import Foundation

import RxSwift

class Store {
    let state$: BehaviorSubject<State>
    let actions$: BehaviorSubject<Actionable>
    
    func dispatch(_ action: Actionable) {
        print("Dispatching action \(action.description)")
        self.actions$.onNext(action)
    }
    
    init(_ initialState: State) {
        
        state$ = BehaviorSubject<State>(value: initialState)
        actions$ = BehaviorSubject<Actionable>(value: InitialAction())
    }
}

