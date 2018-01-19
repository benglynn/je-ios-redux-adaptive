import Foundation


enum CoreReducer: String {
    case updateIsAdaptedReducer
    case updatePathReducer
    // Adapters add core reducers below
    case activateMenuAdaptationReducer
}

extension CoreReducer {
    var reduce: Reducer<CoreStateSlice> {
        switch self {
        case .updateIsAdaptedReducer:
            return updateIsAdapted
        case .updatePathReducer:
            return updatePath
        case .activateMenuAdaptationReducer:
            return activateMenuAdaptation
        }
    }
}

func updateIsAdapted(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    let updateIsAdaptedAction = action as! UpdateIsAdaptedAction
    return CoreStateSlice(
        isAdapted: updateIsAdaptedAction.isAdapted,
        path: stateSlice.path,
        screensInSession: stateSlice.screensInSession,
        reducers: stateSlice.reducers,
        routes: stateSlice.routes
    )
}


func updatePath(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    let updatePathAction = action as! UpdatePathAction
    return CoreStateSlice(
        isAdapted: stateSlice.isAdapted,
        path: updatePathAction.path,
        screensInSession: stateSlice.screensInSession + 1,
        reducers: stateSlice.reducers,
        routes: stateSlice.routes
    )
}

