import Foundation
import UIKit

struct Route {
    let pattern: String
    let parent: StoryboardName
}

typealias NamedRoute = (viewName: StoryboardName, route: Route)
typealias ViewStackItem = (name: StoryboardName, childNames: [StoryboardName]?)


func findNamedRoute(for path: String, within namedRoutes: [NamedRoute]) -> NamedRoute? {
    if namedRoutes.count == 0 {
        print("no match for '\(path)' - will default to first route in state")
        return nil
    }
    let first = namedRoutes[0]
    if let _ = path.range(of: first.1.pattern, options: .regularExpression) {
        print("\(first.viewName.rawValue) matched '\(path)'")
        return first
    }
    return findNamedRoute(for: path, within: Array(namedRoutes[1...]))
}

func instantiateView(viewName: StoryboardName) -> UIViewController {
    return UIStoryboard(name: viewName.rawValue, bundle: nil).instantiateInitialViewController()!
}

func compileViewStack(for state: State) -> [ViewStackItem] {
    
    let namedRoutes = state.config.routes.map {(viewName: $0, route: $1)}
    let resolvedNamedRoute = findNamedRoute(for: state.core.path, within: namedRoutes) ?? namedRoutes[0]
    print("Resolved \(resolvedNamedRoute.viewName.rawValue)")
    
    // TODO: compile the following from state
    return [
        (name: .TabsView, childNames: [.HomeView, .OrdersView, .SettingsView]),
        (name: .HomeView, childNames: nil)
    ]

}
