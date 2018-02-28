import Foundation

func updateRestaurantsReducer(currentSlice: SearchStateSlice, dispatchedAction: Actionable) -> SearchStateSlice {
    let restaurants = (dispatchedAction as! UpdateRestaurantsAction).restuarnts
    return currentSlice.cloneWith(restaurants: restaurants)
}
