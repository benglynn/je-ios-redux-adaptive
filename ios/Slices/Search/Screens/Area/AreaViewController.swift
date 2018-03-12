import UIKit
import RxSwift
import RxCocoa

class AreaViewController: UIViewController, Presentable {
    
    // MARK: Presentable
    static let storyboardName = "Area"
    internal var store: Store!
    let bag = DisposeBag()

    // MARK: Interface Builder
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var progress: UIView!
    
    @IBAction func tapHome(_ sender: Any) {
        store.dispatch(UpdatePathAction(path: ""))
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        flowLayout.invalidateLayout()
    }
    
    // MARK: Setup
    
    private func setupData() {
    progress.rotateForever()
    self.store.selectRestaurants()
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { restaurants in
        self.progress.isHidden = restaurants != nil
    }).disposed(by: bag)
    }
    
    private func setupCollectionView() {
        flowLayout.estimatedItemSize = flowLayout.itemSize
        collectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "resultCell")
        self.store
            .selectRestaurants()
            .map { restaurants -> [Restaurant] in restaurants ?? [] }
            .bind(to: collectionView.rx.items(cellIdentifier: "resultCell")) { index, state, resultCell in
                (resultCell as! ResultCollectionViewCell).update(state)
            }
            .disposed(by: bag)
    }
}

