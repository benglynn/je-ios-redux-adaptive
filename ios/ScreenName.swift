import UIKit

enum ScreenName: String {
    case Home
    case Area
    case Orders
    case Settings
    case Restaurants
    case Tabs
    
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
    let screen: ScreenName
    let children: [ScreenName]?
}




