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
        // TODO: this logic should be in an effect associated with route change
        let searchService = SearchService(q: "bs34sh")
        searchService.get().subscribe(onNext: { response in
             print("Response has \(response.MetaData.ResultCount) reults")
        }).disposed(by: bag)
    }
    
}
