import UIKit

class RestaurantsViewController: UINavigationController, Presentable {
    
    static let storyboardName = "Restaurants"
    var store: Store!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
    }
}
