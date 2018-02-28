import UIKit
import RxSwift

class AreaViewController: UIViewController, Presentable {
    
    static let storyboardName = "Area"
    internal var store: Store!
    let bag = DisposeBag()
    
    @IBAction func tapHome(_ sender: Any) {
        store.dispatch(UpdatePathAction(path: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.store
            .selectRestaurants()
            .subscribe(onNext: { restaurants in
                print("Recived \(restaurants == nil ? 0 : restaurants!.count) rstaurants")
            })
            .disposed(by: bag)

    }
    
}
