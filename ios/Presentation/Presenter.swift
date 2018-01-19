import Foundation
import UIKit

struct Presenter {
    
    static func present(_ state: State, on parent: UIViewController, injecting store: Store) {
        present(currentScreenFamilyStack(state), on: parent, isChild: false, injecting: store)
    }
    
    private static func present(_ screenFamilyStack: [ScreenFamily], on parent: UIViewController, isChild: Bool, injecting store: Store) {
        let family = screenFamilyStack[0],
            viewController = family.screen.create(injecting: store),
            viewControllerType = type(of: viewController),
            nextIsChild = family.children != nil,
            nextIsLast = screenFamilyStack.count == 2,
            thisIsLast = screenFamilyStack.count == 0,
            isAnimated = (nextIsChild && nextIsLast) || thisIsLast
        
        let foundInParent: UIViewController? = {
            switch parent {
            case let tabs as UITabBarController:
                if let matchingChild = (tabs.viewControllers?.first { type(of: $0) == viewControllerType }) {
//                    print("Found \(family.screen) in \(parent)")
                    return matchingChild
                } else { return nil }
            case let navStack as UINavigationController:
                if let matchingChild = (navStack.viewControllers.first { type(of: $0) == viewControllerType }) {
//                    print("Found \(family.screen) in \(parent)")
                    return matchingChild
                } else { return nil }
            default: return nil
            }
        }()
        
        let presentedOnParent: UIViewController? = {
            if foundInParent != nil { return nil }
            
            if parent.presentedViewController != nil && type(of: parent.presentedViewController!) == viewControllerType {
//                print("\(family.screen) already presented on \(parent)")
                return parent.presentedViewController
            } else {
//                print("Presenting \(family.screen) on \(parent)")
                let viewController = family.screen.create(injecting: store)
                parent.present(viewController, animated: isAnimated, completion: nil) // TODO: animate true for all but first
                return viewController
            }
        }()
        
        let foundOrPresented = foundInParent ?? presentedOnParent!
        
        if let childNames = family.children {
            guard screenFamilyStack.count > 0, childNames.contains(screenFamilyStack[1].screen) else {
                fatalError("Expected next in stack to be child of \(foundOrPresented)")
            }
            func reuseEach(_ incumbents: [UIViewController]?, orCreate screens: [Screen]) -> [UIViewController] {
                guard incumbents != nil else { return screens.map { $0.create(injecting: store) } }
                return screens.enumerated().map { (i, screen) in
                    let childViewController = screen.create(injecting: store)
                    return incumbents!.indices.contains(i) && type(of: incumbents![i]) == type(of: childViewController)
                        ? incumbents![i] : childViewController
                }
            }
            let selectedChild = screenFamilyStack[1].screen
            switch foundOrPresented {
                
            case let tabs as UITabBarController:
                tabs.setViewControllers(reuseEach(tabs.viewControllers, orCreate: childNames), animated: isAnimated)
//                print("Selecting \(selectedChild) in \(parent)")
                tabs.selectedViewController = tabs.viewControllers!.first { type(of: $0) == type(of: selectedChild.create(injecting: store)) }
                
            case let navStack as UINavigationController:
                guard childNames.last == selectedChild else {
                    fatalError("Expected last child of \(parent) to be \(selectedChild)")
                }
//                print("Selecting \(selectedChild) in \(parent)")
                navStack.setViewControllers(reuseEach(navStack.viewControllers, orCreate: childNames), animated: isAnimated)
                
            default:
                fatalError("Unable to add children to an unknown parent type")
            }
        }
        if screenFamilyStack.count > 1 && !(nextIsLast && nextIsChild) {
            present(Array(screenFamilyStack[1...]), on: foundOrPresented, isChild: nextIsChild, injecting: store)
        }
    }
    
    private static func currentScreenFamilyStack(_ state: State) -> [ScreenFamily] {
        let match = state.core.routes.first {
            state.core.path.range(of: $0.pathPattern.rawValue, options: .regularExpression) != nil
        }
        print(match == nil ? "No path match" : "Path matched: \(match!.pathPattern)")
        return match?.screens ?? state.core.routes[0].screens
    }
}




