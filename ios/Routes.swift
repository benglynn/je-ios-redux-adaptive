import Foundation
import UIKit

struct Route {
    let pattern: String
    let parent: ViewName
}

func currentView(forState state: State) -> [UIViewController] {
    
    func findRouteFor(path: String, within routes: [(viewName: ViewName, route: Route)]) -> (viewName: ViewName, route: Route)? {
        if routes.count == 0 {
            return nil
        }
        let first = routes[0]
        if let _ = path.range(of: first.1.pattern, options: .regularExpression) {
            print("\(first.route.pattern) matched \(path)")
            return routes[0]
        }
        print("\(first.route) did not match \(path)")
        return findRouteFor(path: path, within: Array(routes[1...]))
    }
    let path = "" // TODO: deep links
    let defaultRoute = (ViewName.HomeView, state.config.routes[.HomeView]!)
    let matchedRoute = findRouteFor(path: path, within: state.config.routes.map {(viewName: $0, route: $1)})
    let resolvedRoute = matchedRoute ?? defaultRoute
    
    
    func ancestry(childViewName: ViewName, config: State.Config) {}
    
    return [UIStoryboard(name: resolvedRoute.viewName.rawValue, bundle: nil).instantiateInitialViewController()!]

}
