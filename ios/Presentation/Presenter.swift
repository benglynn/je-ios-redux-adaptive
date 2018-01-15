import Foundation
import UIKit

struct Presenter {
    
    static func present(_ state: State, on parent: UIViewController, injecting store: Store) {
        present(currentScreenFamilyStack(state), on: parent, injecting: store)
    }
    
    private static func currentScreenFamilyStack(_ state: State) -> [ScreenFamily] {
        let match = state.config.routes.first {
            state.core.path.range(of: $0.pathPattern.rawValue, options: .regularExpression) != nil
        }
        print(match == nil ? "No path match" : "Path matched: \(match!.pathPattern)")
        return match?.screens ?? state.config.routes[0].screens
    }
    
    private static func present(_ screenFamilyStack: [ScreenFamily], on parent: UIViewController, injecting store: Store) {
        let lastScreen = screenFamilyStack.count == 1,
            family = screenFamilyStack[0],
            screenType = family.screen.viewControllerType
        
        let foundInParent: UIViewController? = {
            switch parent {
            case let tabs as UITabBarController:
                if let matchingChild = (tabs.viewControllers?.first { type(of: $0) == screenType }) {
                    print("Found \(family.screen) in \(parent)")
                    return matchingChild
                } else { return nil }
            case let navStack as UINavigationController:
                if let matchingChild = (navStack.viewControllers.first { type(of: $0) == screenType }) {
                    print("Found \(family.screen) in \(parent)")
                    return matchingChild
                } else { return nil }
            default: return nil
            }
        }()
        
        let presentedOnParent: UIViewController? = {
            if foundInParent != nil { return nil }
            
            if parent.presentedViewController != nil && type(of: parent.presentedViewController!) == screenType {
                print("\(family.screen) already presented on \(parent)")
                return parent.presentedViewController
            } else {
                print("Presenting \(family.screen) on \(parent)")
                let viewController = family.screen.create(injecting: store)
                parent.present(viewController, animated: lastScreen, completion: nil) // TODO: animate true for all but first
                return viewController
            }
        }()
        
        let foundOrPresented = foundInParent ?? presentedOnParent!
        
        func reuseEach(_ incumbents: [UIViewController]?, orCreate screens: [Screen]) -> [UIViewController] {
            guard incumbents != nil else { return screens.map { $0.create(injecting: store) } }
            return zip(screens, incumbents!).map { screen, incumbent in
                screen.viewControllerType == type(of: incumbent) ? incumbent : screen.create(injecting: store) }
        }
        
        if let childNames = family.children {
            guard screenFamilyStack.count > 0, childNames.contains(screenFamilyStack[1].screen) else {
                fatalError("Expected next in stack to be child of \(foundOrPresented)")
            }
            switch foundOrPresented {
            case let tabs as UITabBarController:
                tabs.setViewControllers(reuseEach(tabs.viewControllers, orCreate: childNames), animated: true)
                let selectedChild = screenFamilyStack[1].screen
                print("Selecting \(selectedChild) in \(parent)")
                tabs.selectedViewController = tabs.viewControllers!.first { type(of: $0) == selectedChild.viewControllerType }
            case let navStack as UINavigationController:
                navStack.setViewControllers(childNames.map { $0.create(injecting: store) }, animated: false) // TODO: animated sometimes
                
            default:
                fatalError("Unable to add children to an unknown parent type")
            }
        }
        if screenFamilyStack.count > 1 {
            present(Array(screenFamilyStack[1...]), on: foundOrPresented, injecting: store)
        }
    }
}




