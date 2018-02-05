import UIKit
import RxSwift

class MenuHomeViewController: UIViewController, Presentable {
    
    var hasAnimated = false
    
    // MARK: - Presnentable
    
    static let storyboardName = "MenuHome"
    internal var store: Store!
    let bag = DisposeBag()
    
    func setStore(store: Store) {
        self.store = store
    }
    
    // MARK: - Interface Builder
    
    @IBOutlet weak var hamburger: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func tapHamburger(_ sender: Any) {
        store.dispatch(PresentMenuAction())
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hamburger.alpha = 1
        let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
        homeView.setStore(store: store)
        addChildViewController(homeView)
        homeView.view.frame = self.containerView.frame
        containerView.addSubview(homeView.view)
        homeView.didMove(toParentViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let mainQueue = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.main)
        super.viewDidAppear(animated)
        guard self.hasAnimated == false else { return }
        hamburger.alpha = 0
        store.state$
            .delay(0.1, scheduler: mainQueue) // safe area moves down otherwise. TODO: why?
            .map { $0.core.screensInSession }.filter { $0 == 1 }.take(1)
            .subscribe(onNext: { _ in
                UIView.animate(withDuration: 0.5, delay: 1.1, options: .curveEaseOut, animations: {[weak self] in
                    self?.hamburger.alpha = 1.0
                    self?.view.layoutIfNeeded()
                })
                self.hasAnimated = true
            }).disposed(by: bag)
    }
}

