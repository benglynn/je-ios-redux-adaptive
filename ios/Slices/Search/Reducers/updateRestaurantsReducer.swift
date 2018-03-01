import Foundation

func updateRestaurantsReducer(currentSlice: SearchStateSlice, dispatchedAction: Actionable) -> SearchStateSlice {
    let restaurants = (dispatchedAction as! UpdateRestaurantsAction).restuarnts
    switch restaurants {
    case .none:
        return currentSlice.cloneWith(restaurants: Optional.none)
    case .some:
        return currentSlice.cloneWith(restaurants: Optional.some(value: restaurants!))
    }
}
