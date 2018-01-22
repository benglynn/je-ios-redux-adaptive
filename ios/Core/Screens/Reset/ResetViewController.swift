import UIKit

class ResetViewController: UIViewController, Presentable {
    var store: Store!
    static var storyboardName = "Reset"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.dispatch(initStateAction())
    }
}
