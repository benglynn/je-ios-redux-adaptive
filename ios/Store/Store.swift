import Foundation

import RxSwift

class Store {
    let state$: BehaviorSubject<State>
    
    init(_ initialState: State) {
        state$ = BehaviorSubject<State>(value: initialState)
    }
}

