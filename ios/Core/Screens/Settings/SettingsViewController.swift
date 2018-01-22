import UIKit

class SettingsViewController: UIViewController, Presentable {
    
    // MARK: - Presentable
    
    static let storyboardName = "Settings"
    var store: Store!
    
    // MARK: IB
    
    @IBAction func tapReset(_ sender: Any) {
        store.dispatch(ResetAction())
    }
}
