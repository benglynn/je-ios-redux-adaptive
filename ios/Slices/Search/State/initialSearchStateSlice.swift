import Foundation

let initialSearchStateSlice = SearchStateSlice(
    postcode: nil,
    restaurants: [],
    reducers: [
        .updatePostcodeAction: .updatePostcodeReducer,
        .updateRestaurantsAction: .updateRestaurantsReducer
    ]
)
