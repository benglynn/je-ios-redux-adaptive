import Foundation


enum CoreReducer: String {
    case updateIsAdaptedReducer
    case resetReducer
    case updatePathReducer
    case dismissLastReducer
    // Adapters add core reducers below
    case activateMenuAdaptationReducer
    case presentMenuReducer
}

extension CoreReducer {
    var reduce: Reducer<CoreStateSlice> {
        switch self {
        case .updateIsAdaptedReducer: return updateIsAdapted
        case .resetReducer: return reset
        case .updatePathReducer: return updatePath
        case .activateMenuAdaptationReducer: return activateMenuAdaptation
        case .presentMenuReducer: return presentMenu
        case .dismissLastReducer: return dismissLast
        }
    }
}

func dismissLast(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    guard currentSlice.screenFamilyStack.count > 1 else {
        return currentSlice
    }
    return currentSlice.cloneWithOverrides(
        screenFamilyStack: Array(currentSlice.screenFamilyStack.dropLast())
    )
}

func reset(currentSlice: CoreStateSlice, dispatechedAction: Actionable) -> CoreStateSlice {
    guard currentSlice.screenFamilyStack.last?.screen != .Reset else {
        return currentSlice
    }
    return currentSlice.cloneWithOverrides(
        screenFamilyStack: currentSlice.screenFamilyStack + [ScreenFamily(screen: .Reset, children: nil)]
    )
}

func updateIsAdapted(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    let updateIsAdaptedAction = action as! UpdateIsAdaptedAction
    return stateSlice.cloneWithOverrides(
        isAdapted: updateIsAdaptedAction.isAdapted
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

func updatePath(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    let updatePathAction = dispatchedAction as! UpdatePathAction
    
    let pathAndStack: (path: String, stack: [ScreenFamily]) = {
        if let stack = matchingStack(forPath: updatePathAction.path, inRoutes: currentSlice.routes) {
            return (path: updatePathAction.path, stack: stack)
        } else {
            print("Defaulting to empty path")
            return (path: "", stack: matchingStack(forPath: "", inRoutes: currentSlice.routes)!)
        }
    }()
    return currentSlice.cloneWithOverrides(
        path: pathAndStack.path,
        screensInSession: currentSlice.screensInSession + 1,
        screenFamilyStack: pathAndStack.stack
    )
}

