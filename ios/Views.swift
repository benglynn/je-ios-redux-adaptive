import UIKit

enum StoryboardName: String {
    case TabsView
    case RestaurantsView
    case HomeView
    case OrdersView
    case SettingsView
    
    func viewControllerType() -> UIViewController.Type {
        // TODO: do this without wasted instantiation
        return type(of: createViewController())
    }
    
    func createViewController() -> UIViewController {
        return createStoryboard().instantiateInitialViewController()!
    }
    
    func createStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: nil)
    }
}


