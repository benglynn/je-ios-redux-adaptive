import UIKit

protocol StoreDepending {
    
    var store: Store! { get set }
    
    func setStore(store: Store)
}
