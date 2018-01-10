import Foundation
import UIKit

enum PathPattern: String {
    case HomePath = "^$"
    case OrdersPath = "^orders$"
    case SettingsPath = "^settings$"
    case AreaPath = "^bs14dj$" // TODO: postcode regex
}


// TODO: What is this actually called? Where does this essential code live?
struct Route {
    
    static func present(_ state: State, on parent: UIViewController, injecting store: Store) {
        present(currentScreenFamilyStack(state), on: parent, injecting: store)
    }
    
    private static func currentScreenFamilyStack(_ state: State) -> [ScreenFamily] {
        let match = state.config.routes_.first {
            state.core.path.range(of: $0.pathPattern.rawValue, options: .regularExpression) != nil
        }
        print(match == nil ? "No path match" : "Path matched: \(match!.pathPattern)")
        return match?.screens ?? state.config.routes_[0].screens
    }
    
    private static func present(_ screenFamilyStack: [ScreenFamily], on parent: UIViewController, injecting store: Store) {
        let family = screenFamilyStack[0], screenType = family.screen.viewControllerType()
        
        let selectedInParent: UIViewController? = {
            switch parent {
            case let tabs as UITabBarController:
                if let matchingChild = (tabs.viewControllers?.first { type(of: $0) == screenType }) {
                    print("Selecting \(family.screen) in \(parent)")
                    tabs.selectedViewController = matchingChild
                    return matchingChild
                } else { return nil }
            case let navStack as UINavigationController:
                if let matchingChild = (navStack.viewControllers.first { type(of: $0) == screenType }) {
                    // TODO: pop non-matching views off the stack
                    return matchingChild
                } else { return nil }
            // TODO: handle other types of parent
            default: return nil
            }
        }()
        
        let presentedOnParent: UIViewController? = {
            if selectedInParent != nil {
                return nil
            }
            if type(of: parent.presentedViewController) == screenType {
                print("\(family.screen) already presented on \(parent)")
                return parent.presentedViewController
            } else {
                print("Presenting \(family.screen) on \(parent)")
                let viewController = family.screen.createViewController(injecting: store)
                parent.present(viewController, animated: false, completion: nil) // TODO: animate true for all but first
                return viewController
            }
        }()
        
        let selectedOrPresented = selectedInParent ?? presentedOnParent!
        
        if let childNames = family.children {
            switch selectedOrPresented {
            case let tabs as UITabBarController:
                tabs.viewControllers = childNames.map { $0.createViewController(injecting: store) } // TODO: don't clobber existing children
            case let navStack as UINavigationController:
                navStack.setViewControllers(childNames.map { $0.createViewController(injecting: store) }, animated: false) // TODO: animated sometimes
            default:
                fatalError("Unable to add children to an unknown parent type")
            }
        }
        if screenFamilyStack.count > 1 {
            present(Array(screenFamilyStack[1...]), on: selectedOrPresented, injecting: store)
        }
    }
}




