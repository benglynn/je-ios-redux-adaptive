import UIKit

protocol StoreDepending: class {
    
    var store: Store! { get set }
    
    func setStore(store: Store)
}

extension StoreDepending {
    func setStore(store: Store) {
        self.store = store
    }
}
