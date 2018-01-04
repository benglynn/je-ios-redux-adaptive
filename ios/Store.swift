import Foundation

import RxSwift

struct Store {
    let state$: BehaviorSubject<State>
}

let store = Store(state$: BehaviorSubject<State>(value: initialState))
