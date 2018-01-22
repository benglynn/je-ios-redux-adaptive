import UIKit

class MenuOrdersViewController: UIViewController, Presentable {
    
    // MARK: - Presentable
    static var storyboardName = "MenuOrders"
    var store: Store!
    
    // MARK: - IB
    
    @IBAction func tapClose(_ sender: Any) {
        store.dispatch(DismissLastAction())
    }
}
