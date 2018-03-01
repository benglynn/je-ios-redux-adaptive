import Foundation

extension SearchStateSlice {
    func cloneWith(
        postcode: Optional<String>? = nil,
        restaurants: Optional<[Restaurant]>? = nil,
        reducers: [Action : SearchReducer]? = nil
    ) -> SearchStateSlice {
        return SearchStateSlice(
            postcode: value(from: postcode, or: self.postcode),
            restaurants: value(from: restaurants, or: self.restaurants),
            reducers: reducers ?? self.reducers
        )
    }
}
