import Foundation

func updatePath (stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    let updatePathAction = action as! UpdatePathAction
    return CoreStateSlice(
        path: updatePathAction.path,
        screensInSession: stateSlice.screensInSession + 1
    )
}

enum CoreReducer: String {
    case updatePathReducer
    // Adapters add core reducers here
    
    var reduce: Reducer<CoreStateSlice> {
        switch self {
        case .updatePathReducer:
            return updatePath
        }
    }
}

