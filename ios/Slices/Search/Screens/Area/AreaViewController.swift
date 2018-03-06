import UIKit
import RxSwift
import RxCocoa

class AreaViewController: UIViewController, Presentable {
    
    static let storyboardName = "Area"
    internal var store: Store!
    let bag = DisposeBag()
    let minCellWidth = CGFloat(300)
    let cellHeight = CGFloat(200)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBAction func tapHome(_ sender: Any) {
        store.dispatch(UpdatePathAction(path: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ResultCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "resultCell")
        _ = collectionView.rx.setDelegate(self)
        
        self.store
            .selectRestaurants()
            .map { restaurants in restaurants ?? [] }
            .bind(to: collectionView.rx.items(cellIdentifier: "resultCell")) { index, state, resultCell in
                (resultCell as! ResultCollectionViewCell).update(state)
            }
            .disposed(by: bag)
    }
}

extension AreaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = self.view.safeAreaLayoutGuide.layoutFrame.width // self.view.frame.width
        let width = frameWidth / round(frameWidth / minCellWidth)
        return CGSize(width: width, height: cellHeight)
    }
}
