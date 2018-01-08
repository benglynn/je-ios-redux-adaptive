import Foundation
import UIKit

struct Route {
    let pattern: String
    let parent: StoryboardName
    
    static func present(_ state: State, on parent: UIViewController) {
        let viewStack = Route.compileViewStack(for: state)
        Route.present(viewStack, on: parent)
    }
    
    
    // MARK: - Types
    
    private typealias StoryboardNameStack = [StoryboardNameStackItem]
    
    private struct StoryboardNameStackItem {
        let name: StoryboardName
        let childNames: [StoryboardName]?
    }
    
    private typealias NamedRoute = (name: StoryboardName, route: Route)
    
    
    // MARK: - Compile view stack for state route matching state path
    
    private static func compileViewStack(for state: State) -> StoryboardNameStack {
        
        let namedRoutes = state.config.routes.map {(name: $0, route: $1)}
        let resolvedNamedRoute = Route.findNamedRoute(for: state.core.path, within: namedRoutes) ?? namedRoutes[0]
        print("Resolved \(resolvedNamedRoute.name.rawValue)")
        
        // TODO: compile the following from state
        return [
            StoryboardNameStackItem(name: .TabsView, childNames: [.RestaurantsView, .OrdersView, .SettingsView]),
            StoryboardNameStackItem(name: .RestaurantsView, childNames: [.HomeView]),
            StoryboardNameStackItem(name: .HomeView, childNames: nil)
        ]
    }
    
    private static func findNamedRoute(for path: String, within namedRoutes: [NamedRoute]) -> NamedRoute? {
        if namedRoutes.count == 0 {
            print("no match for '\(path)' - will default to first route in state")
            return nil
        }
        let first = namedRoutes[0]
        if let _ = path.range(of: first.1.pattern, options: .regularExpression) {
            print("\(first.name.rawValue) matched '\(path)'")
            return first
        }
        return findNamedRoute(for: path, within: Array(namedRoutes[1...]))
    }
    
    
    // MARK: - Present compiled view stack on view controller
    
    private  static func present(_ nameStack: Route.StoryboardNameStack, on parent: UIViewController) {
        
        let first = nameStack[0], firstType = first.name.viewControllerType()
        
        let selectedInParent: UIViewController? = {
            switch parent {
            case let tabs as UITabBarController:
                if let matchingChild = (tabs.viewControllers?.first { type(of: $0) == firstType }) {
                    print("Selecting \(first.name) in \(parent)")
                    tabs.selectedViewController = matchingChild
                    return matchingChild
                } else { return nil }
            case let navStack as UINavigationController:
                if let matchingChild = (navStack.viewControllers.first { type(of: $0) == firstType }) {
                    // TODO: pop away non matching views
                    return matchingChild
                }
                else { return nil }
            // TODO: Check for all types of parent
            default: return nil
            }
        }()
        
        let presentedOnParent: UIViewController? = {
            if selectedInParent != nil {
                return nil
            }
            if type(of: parent.presentedViewController) == firstType {
                print("\(first.name) already presented on \(parent)")
                return parent.presentedViewController
            } else {
                print("Presneting \(first.name) on \(parent)")
                let viewController = first.name.createViewController()
                parent.present(viewController, animated: false, completion: nil) // TODO: animated true for all but first view
                return viewController
            }
        }()
        
        let selectedOrPresnted = selectedInParent != nil ? selectedInParent! : presentedOnParent!
        
        if let childNames = first.childNames {
            switch selectedOrPresnted {
            case let tabs as UITabBarController:
                tabs.viewControllers = childNames.map { $0.createViewController() } // TODO: don't clobber existing children!
            // TODO: Check for all types of parent
            case let navStack as UINavigationController:
                navStack.setViewControllers(childNames.map {$0.createViewController()}, animated: false) // TODO: animated sometimes
                
            default:
                fatalError("Unable to add children to an unknown parent type")
            }
        }
        if nameStack.count > 1 {
            present(Array(nameStack[1...]), on: selectedOrPresnted)
        }
        // TODO: test coversage validates ancestry?
    }
}




