import Foundation
import RxSwift

extension Store {
    func selectRestaurants() -> Observable<[Restaurant]?> {
        return self.state$
            .map { state -> [Restaurant]? in
                return state.search.restaurants
            }.distinctUntilChanged({ (a, b) -> Bool in
                switch a {
                case .none: return b == nil
                case .some: return b != nil && Array(a!) == Array(b!)
                }
            })
        
    }
}
