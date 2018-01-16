import Foundation

// TODO: reducers return optionals and influence failable State init
func updateIsAdapted (stateSlice: ConfigStateSlice, action: Actionable) -> ConfigStateSlice {
    let updateIsAdaptedAction = action as! UpdateIsAdaptedAction
    if stateSlice.isAdapted == updateIsAdaptedAction.isAdapted {
        return stateSlice
    }
    return ConfigStateSlice(
        isAdapted: updateIsAdaptedAction.isAdapted,
        config: stateSlice.config,
        core: stateSlice.core)
}

enum ConfigReducer: String {
    case updateIsAdaptedReducer
    // Adapters add config reducers here
    
    var reduce: Reducer<ConfigStateSlice> {
        switch self {
        case .updateIsAdaptedReducer:
            return updateIsAdapted
        }
    }
}
