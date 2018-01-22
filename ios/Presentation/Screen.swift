import UIKit

enum Screen: String {
    case Area
    case Home
    case Orders
    case Restaurants
    case Settings
    case Tabs
    case Reset
    // Adaptors add screens here
    case Menu
    case MenuHome
    case MenuOrders
    case MenuSettings
}

extension Screen {
    func create(injecting store: Store) -> UIViewController & Presentable {
        switch self {
        case .Area: return AreaViewController.create(injecting: store)
        case .Home: return HomeViewController.create(injecting: store)
        case .Orders: return OrdersViewController.create(injecting: store)
        case .Restaurants: return RestaurantsViewController.create(injecting: store)
        case .Settings: return SettingsViewController.create(injecting: store)
        case .Tabs: return TabsViewController.create(injecting: store)
        case .Reset: return ResetViewController.create(injecting: store)
        case .Menu: return MenuViewController.create(injecting: store)
        case .MenuHome: return MenuHomeViewController.create(injecting: store)
        case .MenuOrders: return MenuOrdersViewController.create(injecting: store)
        case .MenuSettings: return MenuSettingsViewController.create(injecting: store)
        }
    }
}

struct ScreenFamily {
    let screen: Screen
    let children: [Screen]?
}




