import Foundation

struct SearchStateSlice: Reducible /* TODO: Codable */ {
    let postcode: String?
    let restaurants: [Restaurant]
    let reducers: [Action : SearchReducer]
}

import RxSwift

extension Store {
    func selectRestaurants() -> Observable<[Restaurant]> {
        return self.state$
            .map { state in return state.area.restaurants }
            .distinctUntilChanged { (a, b) -> Bool in
                return Array(a) == Array(b)
        }
    }
}
