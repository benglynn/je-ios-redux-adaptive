import UIKit

class MenuOrdersViewController: UIViewController, Presentable {
    
    // MARK: - Presentable
    static var storyboardName = "MenuOrders"
    var store: Store!
    
    // MARK: - Interface Builder
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func tapClose(_ sender: Any) {
        store.dispatch(DismissLastScreenFamilyAction())
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let ordersView = UIStoryboard(name: "Orders", bundle: nil).instantiateInitialViewController() as! OrdersViewController
        ordersView.setStore(store: store)
        addChildViewController(ordersView)
        ordersView.view.frame = containerView.frame
        ordersView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(ordersView.view)
        ordersView.didMove(toParentViewController: self)
    }
    
    
}
