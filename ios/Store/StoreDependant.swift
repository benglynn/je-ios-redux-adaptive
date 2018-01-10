import UIKit

protocol StoreDependant {
    
    var store: Store! { get set }
    
    func setStore(store: Store)
}
