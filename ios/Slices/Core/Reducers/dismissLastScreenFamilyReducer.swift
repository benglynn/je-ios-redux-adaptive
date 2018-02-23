import Foundation

func dismissLastScreenFamilyReducer(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    guard currentSlice.screenFamilyStack.count > 1 else {
        return currentSlice
    }
    return currentSlice.cloneWith(
        screenFamilyStack: Array(currentSlice.screenFamilyStack.dropLast())
    )
}
