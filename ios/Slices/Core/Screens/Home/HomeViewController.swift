import UIKit
import RxSwift

class HomeViewController: UIViewController, Presentable {
    
    static let storyboardName = "Home"
    internal var store: Store!
    let bag = DisposeBag()
    
    func setStore(store: Store) {
        self.store = store
    }

    @IBOutlet weak var rays: RaysView!
    @IBOutlet weak var contents: UIStackView!
    
    @IBAction func tapSearch(_ sender: Any) {
        self.store.dispatch(UpdatePathAction("bs14dj"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.state$.map { $0.core.screensInSession }.filter { $0 == 0 }.take(1)
            .subscribe(onNext: { _ in
                self.rays.isFirstViewOfSession = true
                self.contents.alpha = 0
            }).disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.state$.map { $0.core.screensInSession }.filter { $0 == 0 }.take(1)
            .subscribe(onNext: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {[weak self] in
                    self?.view.layoutIfNeeded() }
                )
                UIView.animate(withDuration: 0.5, delay: 1.1, options: .curveEaseOut, animations: {[weak self] in
                    self?.contents.alpha = 1.0
                    self?.view.layoutIfNeeded()
                })
            }).disposed(by: bag)
    }
}
