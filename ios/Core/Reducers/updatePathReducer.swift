import Foundation

func matchingStack(forPath path: String, inRoutes routes: [Route]) -> [ScreenFamily]? {
    let match = routes.first {
        path.range(of: $0.pathPattern.rawValue, options: .regularExpression) != nil
    }
    if let matchingScreens = match?.screens { return matchingScreens }
    print("No match for \(path)")
    return nil
}

func updatePathReducer(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    let updatePathAction = dispatchedAction as! UpdatePathAction
    
    let pathAndStack: (path: String, stack: [ScreenFamily]) = {
        if let stack = matchingStack(forPath: updatePathAction.path, inRoutes: currentSlice.routes) {
            return (path: updatePathAction.path, stack: stack)
        } else {
            print("Defaulting to empty path")
            return (path: "", stack: matchingStack(forPath: "", inRoutes: currentSlice.routes)!)
        }
    }()
    return currentSlice.cloneWith(
        path: pathAndStack.path,
        screensInSession: currentSlice.screensInSession + 1,
        screenFamilyStack: pathAndStack.stack
    )
}

