import Foundation

extension SearchStateSlice {
    func cloneWith(
        postcode: Optional<String>? = nil,
        restaurants: [Restaurant]? = nil,
        reducers: [Action : SearchReducer]? = nil
    ) -> SearchStateSlice {
        return SearchStateSlice(
            postcode: value(from: postcode, or: self.postcode),
            restaurants: restaurants ?? self.restaurants,
            reducers: reducers ?? self.reducers
        )
    }
}
