import UIKit

protocol Presentable: StoreDepending where Self: UIViewController {
    static var storyboardName: String { get }
    static func create(injecting: Store) -> UIViewController & Presentable
}

extension Presentable {
    static func create(injecting store: Store) -> UIViewController & Presentable {
        let viewController = UIStoryboard(name: self.storyboardName, bundle: nil)
            .instantiateInitialViewController()!
        if let storeDepending = viewController as? StoreDepending {
            storeDepending.setStore(store: store)
        }
        return viewController as! UIViewController & Presentable
    }
}
