import Foundation

func updatePostcodeReducer(currentSlice: SearchStateSlice, dispatchedAction: Actionable) -> SearchStateSlice {
    let postcode = (dispatchedAction as! UpdatePostcodeAction).postcode
    switch postcode {
    case .none: return currentSlice.cloneWith(postcode: Optional.noValue)
    case .some: return currentSlice.cloneWith(postcode: Optional.value(value: postcode!))
    }
}
