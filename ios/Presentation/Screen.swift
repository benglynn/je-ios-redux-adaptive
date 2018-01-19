import UIKit

enum Screen: String {
    case Area
    case Home
    case Orders
    case Restaurants
    case Settings
    case Tabs
    // Adaptors add screens here
    
    var viewControllerType: UIViewController.Type {
        switch self {
        case .Area: return AreaViewController.self
        case .Home: return HomeViewController.self
        case .Orders: return OrdersViewController.self
        case .Restaurants: return RestaurantsViewController.self
        case .Settings: return SettingsViewController.self
        case .Tabs: return TabsViewController.self
        }
    }
    
    func create(injecting store: Store) -> UIViewController & Presentable {
        switch self {
        case .Area: return AreaViewController.create(injecting: store)
        case .Home: return HomeViewController.create(injecting: store)
        case .Orders: return OrdersViewController.create(injecting: store)
        case .Restaurants: return RestaurantsViewController.create(injecting: store)
        case .Settings: return SettingsViewController.create(injecting: store)
        case .Tabs: return TabsViewController.create(injecting: store)
        }
    }
}

struct ScreenFamily {
    let screen: Screen
    let children: [Screen]?
}




