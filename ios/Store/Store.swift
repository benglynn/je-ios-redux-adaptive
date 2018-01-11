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
        
        action$
            .withLatestFrom(state$) { action, state in return (action, state)}
            .subscribe(onNext: { (action, state) in
                print("Reducing action: \(action)")
                let _:[Slice] = Mirror(reflecting: state).children.map { child in
                    switch child.value {
                    case let coreState as CoreState:
                        return nextSlice(action: action, slice: coreState)
                    case let configurationState as ConfigurationState:
                        return nextSlice(action: action, slice: configurationState)
                    default:
                        fatalError("Unknown state slice type")
                    }
                }
                
            }).disposed(by: bag)
    }
}

func nextSlice<T>(action: Actionable, slice: T) -> T {
    print("Getting next slice for \(type(of: slice))")
    return slice
}

