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
        screensInSession: stateSlice.screensInSession, reducers: stateSlice.reducers,
        screenFamilyStack: stateSlice.screenFamilyStack,
        routes: stateSlice.routes
    )
}

func matchingStack(forPath path: String, inRoutes routes: [Route]) -> [ScreenFamily]? {
    let match = routes.first {
        path.range(of: $0.pathPattern.rawValue, options: .regularExpression) != nil
    }
    if let matchingScreens = match?.screens { return matchingScreens }
    print("No match for \(path)")
    return nil
}

func updatePath(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    let updatePathAction = action as! UpdatePathAction
    
    let pathAndStack: (path: String, stack: [ScreenFamily]) = {
        if let stack = matchingStack(forPath: updatePathAction.path, inRoutes: stateSlice.routes) {
            return (path: updatePathAction.path, stack: stack)
        } else {
            print("Defaulting to empty path")
            return (path: "", stack: matchingStack(forPath: "", inRoutes: stateSlice.routes)!)
        }
    }()
    return CoreStateSlice(
        isAdapted: stateSlice.isAdapted,
        path: pathAndStack.path,
        screensInSession: stateSlice.screensInSession + 1,
        reducers: stateSlice.reducers,
        screenFamilyStack: pathAndStack.stack,
        routes: stateSlice.routes
    )
}

