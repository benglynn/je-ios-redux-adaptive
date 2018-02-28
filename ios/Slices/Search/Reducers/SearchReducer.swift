import Foundation

enum SearchReducer: String, Codable {
    case updatePostcodeReducer
    case updateRestaurantsReducer
    // Adaptors add area reducers below
}

extension SearchReducer {
    var call: ReducerFunc<SearchStateSlice> {
    switch self {
        case .updatePostcodeReducer: return ios.updatePostcodeReducer
        case .updateRestaurantsReducer: return ios.updateRestaurantsReducer
        }
    }
}
