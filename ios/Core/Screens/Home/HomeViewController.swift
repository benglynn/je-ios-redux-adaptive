import UIKit
import RxSwift

class HomeViewController: UIViewController, Presentable {
    
    static let storyboardName = "Home"
    internal var store: Store!
    let bag = DisposeBag()
    var hasAnimated = false
    
    func setStore(store: Store) {
        self.store = store
    }

    @IBOutlet weak var rays: RaysView!
    @IBOutlet weak var contents: UIStackView!
    
    @IBAction func tapSearch(_ sender: Any) {
        self.store.dispatch(UpdatePathAction("bs14dj"))
    }
    
    @IBAction func tapTemp(_ sender: Any) {
        // Temporary trigger until screenStack reducer implemented
        let screen = UIStoryboard(name: "Menu", bundle: nil).instantiateInitialViewController()!
        if let delegate = screen as? UIViewControllerTransitioningDelegate {
                screen.transitioningDelegate = delegate
        }
        let tabsOrRestaurants = UIApplication.shared.keyWindow!.rootViewController!.presentedViewController!
        tabsOrRestaurants.present(screen, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.state$.map { $0.core.screensInSession }.filter { $0 == 1 }.take(1)
            .subscribe(onNext: { _ in
                guard self.hasAnimated == false else { return }
                self.rays.isFirstViewOfSession = true
                self.contents.alpha = 0
            }).disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.state$.map { $0.core.screensInSession }.filter { $0 == 1 }.take(1)
            .subscribe(onNext: { _ in
                guard self.hasAnimated == false else { return }
                UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {[weak self] in
                    self?.view.layoutIfNeeded() }
                )
                UIView.animate(withDuration: 0.5, delay: 1.1, options: .curveEaseOut, animations: {[weak self] in
                    self?.contents.alpha = 1.0
                    self?.view.layoutIfNeeded()
                })
                self.hasAnimated = true
            }).disposed(by: bag)
    }
}
