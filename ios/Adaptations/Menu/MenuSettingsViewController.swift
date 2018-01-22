import UIKit

class MenuSettingsViewController: UIViewController, Presentable {
    
    // MARK: - Presentable
    static var storyboardName = "MenuSettings"
    var store: Store!
    
    // MARK: - IB
    
    @IBAction func tapClose(_ sender: Any) {
        store.dispatch(DismissLastAction())
    }
}

