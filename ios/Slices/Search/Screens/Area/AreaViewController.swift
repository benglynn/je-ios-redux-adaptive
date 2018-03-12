import UIKit
import RxSwift
import RxCocoa

class AreaViewController: UIViewController, Presentable {
    
    // MARK: Presentable
    static let storyboardName = "Area"
    internal var store: Store!
    let bag = DisposeBag()
    
    
    // MARK: UICollectionView
    let minCellWidth = CGFloat(300)
    let nib = UINib(nibName: "ResultCollectionViewCell", bundle: nil)
    var data = [Restaurant]()
    lazy var sizingCell = { return nib.instantiate(withOwner: ResultCollectionViewCell(), options:nil).first as! ResultCollectionViewCell }()

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
        self.data = restaurants ?? []
    }).disposed(by: bag)
    }
    
    private func setupCollectionView() {
        collectionView.register(nib, forCellWithReuseIdentifier: "resultCell")
        _ = collectionView.rx.setDelegate(self)
        self.store
            .selectRestaurants()
            .map { restaurants -> [Restaurant] in restaurants ?? [] }
            // .map { restaurants in restaurants.count == 0 ? [] : Array(restaurants[...10]) }
            .bind(to: collectionView.rx.items(cellIdentifier: "resultCell")) { index, state, resultCell in
                (resultCell as! ResultCollectionViewCell).update(state)
            }
            .disposed(by: bag)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension AreaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCellsInRow = floor(
            (view.safeAreaLayoutGuide.layoutFrame.width - flowLayout.sectionInset.left + flowLayout.minimumInteritemSpacing)
                / (minCellWidth + flowLayout.minimumInteritemSpacing)
        )
        let interCellSpace = (numCellsInRow - 1) * flowLayout.minimumInteritemSpacing
        let cellWidth = floor((view.safeAreaLayoutGuide.layoutFrame.width - flowLayout.sectionInset.left - interCellSpace - flowLayout.sectionInset.right) / numCellsInRow)
        // let cellHeight = sizingCell.preferredHeight(for: data[indexPath.row], at: cellWidth) // 'works' but not at all performant
        let cellHeight: CGFloat = 150
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
