import Foundation

func presentResetScreenReducer(currentSlice: CoreStateSlice, dispatechedAction: Actionable) -> CoreStateSlice {
    guard currentSlice.screenFamilyStack.last?.screen != .Reset else {
        return currentSlice
    }
    return currentSlice.cloneWith(
        screenFamilyStack: currentSlice.screenFamilyStack + [ScreenFamily(screen: .Reset, children: nil)]
    )
}
