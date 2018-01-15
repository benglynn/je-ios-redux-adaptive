import UIKit

class AreaViewController: UIViewController, Presentable {
    
    static let storyboardName = "Area"
    internal var store: Store!
    
    @IBAction func tapHome(_ sender: Any) {
        store.dispatch(UpdatePathAction(""))
    }
    
    
}
