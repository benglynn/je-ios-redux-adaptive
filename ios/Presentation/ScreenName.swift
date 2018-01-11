import UIKit


// TODO: enum UIViewController types, not storyboards

enum ScreenName: String {
    case Home
    case Area
    case Orders
    case Settings
    case Restaurants
    case Tabs
    
    func viewControllerType() -> UIViewController.Type {
        // TODO: do this without wasted instantiation
        let viewController = createStoryboard().instantiateInitialViewController()!
        let typeOf = type(of: viewController)
        return typeOf
    }
    
    func createViewController(injecting store: Store) -> UIViewController {
        let viewController = createStoryboard().instantiateInitialViewController()!
        if let storeDependant = viewController as? StoreDepending {
            storeDependant.setStore(store: store)
        }
        return viewController
    }
    
    private func createStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: nil)
    }
}

struct ScreenFamily {
    let screen: ScreenName
    let children: [ScreenName]?
}




