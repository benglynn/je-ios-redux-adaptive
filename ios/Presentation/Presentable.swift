import UIKit

protocol Presentable: StoreDepending {
    static var storyboardName: String { get }
    static func create(injecting: Store) -> UIViewController
}

extension Presentable {
    static func create(injecting store: Store) -> UIViewController {
        let viewController = UIStoryboard(name: self.storyboardName, bundle: nil)
            .instantiateInitialViewController()!
        if let storeDepending = viewController as? StoreDepending {
            storeDepending.setStore(store: store)
        }
        return viewController
    }
}
