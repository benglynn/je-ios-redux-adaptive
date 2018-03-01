import UIKit
import RxSwift
import RxCocoa

class AreaViewController: UIViewController, Presentable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let storyboardName = "Area"
    internal var store: Store!
    let bag = DisposeBag()
    let tempData = Observable.of(["a", "b", "c"])
    
    @IBAction func tapHome(_ sender: Any) {
        store.dispatch(UpdatePathAction(path: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: "resultCell")
        let nib = UINib(nibName: "ResultCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "resultCell")
        
        self.store
            .selectRestaurants()
            .map { restaurants in restaurants ?? [] }
            .bind(to: collectionView.rx.items(cellIdentifier: "resultCell")) { index, state, resultCell in
                (resultCell as! ResultCollectionViewCell).update(state)
                
            }
            .disposed(by: bag)

    }
    
}
