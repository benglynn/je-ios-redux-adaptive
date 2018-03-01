import Foundation

let initialSearchStateSlice = SearchStateSlice(
    postcode: nil,
    restaurants: nil,
    reducers: [
        .updatePostcodeAction: .updatePostcodeReducer,
        .updateRestaurantsAction: .updateRestaurantsReducer
    ]
)
