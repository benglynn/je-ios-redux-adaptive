import Foundation

struct SearchStateSlice: Reducible /* TODO: Codable */ {
    let postcode: String?
    let restaurants: [Restaurant]?
    let reducers: [Action : SearchReducer]
}

import RxSwift
