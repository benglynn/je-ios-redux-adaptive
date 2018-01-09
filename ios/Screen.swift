import UIKit

enum Screen: String {
    case HomeScreen
    case AreaScreen
    case OrdersScreen
    case SettingsScreen
    case RestaurantsScreen
    case TabsScreen
    
    func viewControllerType() -> UIViewController.Type {
        // TODO: do this without wasted instantiation
        return type(of: createViewController())
    }
    
    func createViewController() -> UIViewController {
        return createStoryboard().instantiateInitialViewController()!
    }
    
    private func createStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: nil)
    }
}

struct ScreenFamily {
    let screen: Screen
    let children: [Screen]?
}




