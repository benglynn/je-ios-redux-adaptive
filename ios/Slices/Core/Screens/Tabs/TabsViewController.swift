import UIKit

class TabsViewController: UITabBarController, UITabBarControllerDelegate, Presentable {
    
    var store: Store!
    static let storyboardName = "Tabs"
    
    func setStore(store: Store) {
        self.store = store
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case _ as RestaurantsViewController:
            self.store.dispatch(UpdatePathAction(""))
        case _ as OrdersViewController:
            self.store.dispatch(UpdatePathAction("orders"))
        case _ as SettingsViewController:
            self.store.dispatch(UpdatePathAction("settings"))
        default:
            fatalError("Unknown tab")
        }
        return false
    }

}
