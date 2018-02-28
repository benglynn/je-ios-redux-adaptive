import Foundation

func matchingRoute(forPath path: String, inRoutes routes: [Route]) -> Route? {
    let match = routes.first {
        path.range(of: $0.pathPattern.rawValue, options: .regularExpression) != nil
    }
    if let matchingRoute = match {
        return matchingRoute
    }
    print("No matching route for \(path)")
    return nil
}

func updatePathReducer(currentSlice: CoreStateSlice, dispatchedAction: Actionable) -> CoreStateSlice {
    let updatePathAction = dispatchedAction as! UpdatePathAction
    
    let pathAndRoute: (path: String, route: Route) = {
        if let route = matchingRoute(forPath: updatePathAction.path, inRoutes: currentSlice.routes) {
            return (path: updatePathAction.path, route: route)
        } else {
            print("Defaulting to empty path")
            return (path: "", route: matchingRoute(forPath: "", inRoutes: currentSlice.routes)!)
        }
    }()
    return currentSlice.cloneWith(
        path: pathAndRoute.path,
        screensInSession: currentSlice.screensInSession + 1,
        screenFamilyStack: pathAndRoute.route.screens,
        route: .value(value: pathAndRoute.route)
    )
}

