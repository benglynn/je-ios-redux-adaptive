import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, Presentable {
    
    // MARK: - Presentable
    static let storyboardName = "Menu"
    var store: Store!
    func setStore(store: Store) {
        self.store = store
    }
    let bag = DisposeBag()
    
    func dismissLast() {
        store.dispatch(DismissLastScreenFamilyAction())
    }
    
    
    // MARK: - Lifecylcle
    
    override func viewDidLoad() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let to = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let from = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let presenting = to != nil
        let menu = presenting ? to! : from!
        let offScreen = CGAffineTransform(translationX: -container.frame.width, y: 0)
        menu.transform = presenting ? offScreen : CGAffineTransform.identity
        container.addSubview(menu)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
            menu.transform = presenting ? CGAffineTransform.identity : offScreen
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
    
    // MARK: - IB
    
    @IBAction func tapOrders(_ sender: Any) {
        dismissLast()
        store.dispatch(UpdatePathAction(path: "orders"))
    }
    
    @IBAction func tapSettings(_ sender: Any) {
        dismissLast()
        store.dispatch(UpdatePathAction(path: "settings"))
    }
    
    @IBAction func tapHamburger(_ sender: Any) {
        dismissLast()
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        dismissLast()
    }
    @IBAction func tapTransparent(_ sender: Any) {
        dismissLast()
    }
}
