import Foundation

func presentMenuReducer(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    guard currentSlice.screenFamilyStack.last?.screen != Screen.Menu else {
        return currentSlice
    }
    return currentSlice.cloneWith(
        screenFamilyStack: currentSlice.screenFamilyStack + [ScreenFamily(screen: .Menu, children: nil)]
    )
}
