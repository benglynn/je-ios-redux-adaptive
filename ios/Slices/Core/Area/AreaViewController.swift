import UIKit

class AreaViewController: UIViewController, StoreDepending {
    
    internal var store: Store!
    
    @IBAction func tapHome(_ sender: Any) {
        store.dispatch(UpdatePathAction(""))
    }
    
    func setStore(store: Store) {
        self.store = store
    }
    
    
}
