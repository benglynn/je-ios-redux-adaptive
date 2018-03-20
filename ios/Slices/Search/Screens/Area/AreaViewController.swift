import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AreaViewController: UIViewController, Presentable {
    
    // MARK: Presentable
    
    static let storyboardName = "Area"
    internal var store: Store!
    let bag = DisposeBag()

    
    // MARK: Interface Builder
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var progress: UIView!
    @IBAction func tapHome(_ sender: Any) { store.dispatch(UpdatePathAction(path: "")) }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.rotateForever()
        setupCollectionView()
    }
    
    // MARK: Collection view setup
    
    private func setupCollectionView() {
        _ = collectionView.rx.setDelegate(self)
        flowLayout.estimatedItemSize = flowLayout.itemSize // TODO: calculate size for dynamic type with sizing nib and long title
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        let headerNib = UINib(nibName: "HeaderCollectionReusableView", bundle: nil) // TODO: from state
        let cellNib = UINib(nibName: "ResultCollectionViewCell", bundle: nil) // TODO: from state
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        
        let dataSource = AreaDataSource(configureCell: configureCell, configureSupplementaryView: configureSupplementaryView)
        self.store
            .selectRestaurants()
            .filter { restaurants in restaurants != nil }
            .map { restaurants -> [AreaSection] in
                return [
                    AreaSection(sectionType: .open, items: restaurants!.filter { restaurant in restaurant.isOpen == true }),
                    AreaSection(sectionType: .closed, items: restaurants!.filter { restaurant in restaurant.isOpen == false })
                ]
            }
            .observeOn(MainScheduler.instance)
            .do(onNext: { _ in self.progress.isHidden = true })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

extension AreaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}

