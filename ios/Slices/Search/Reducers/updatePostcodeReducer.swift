import Foundation

func updatePostcodeReducer(currentSlice: SearchStateSlice, dispatchedAction: Actionable) -> SearchStateSlice {
    let postcode = (dispatchedAction as! UpdatePostcodeAction).postcode
    switch postcode {
    case .none: return currentSlice.cloneWith(postcode: Optional.none)
    case .some: return currentSlice.cloneWith(postcode: Optional.some(value: postcode!))
    }
}
