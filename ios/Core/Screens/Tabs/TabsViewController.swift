import UIKit

class TabsViewController: UITabBarController, UITabBarControllerDelegate, Presentable {
    
    var store: Store!
    static let storyboardName = "Tabs"
    var isFirstView = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstView {
            isFirstView = false
            let barHeight = self.tabBar.frame.size.height
            let originalFrame = self.tabBar.frame
            UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations:  {
                self.tabBar.frame = originalFrame.offsetBy(dx: 0, dy: -(2*barHeight)) // TODO: this is arbitrary, use safe area
            }, completion: nil)
        }
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
