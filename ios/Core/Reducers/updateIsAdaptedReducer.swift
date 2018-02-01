import Foundation

func updateIsAdaptedReducer(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    let updateIsAdaptedAction = action as! UpdateIsAdaptedAction
    return stateSlice.cloneWith(
        isAdapted: updateIsAdaptedAction.isAdapted
    )
}
