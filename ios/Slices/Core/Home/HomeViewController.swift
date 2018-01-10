import UIKit

class HomeViewController: UIViewController, StoreDependant {
    
    internal var store: Store!
    
    func setStore(store: Store) {
        self.store = store
    }

    @IBOutlet weak var rays: RaysView!
    @IBOutlet weak var contents: UIStackView!
    
    @IBAction func tapSearch(_ sender: Any) {
        // TODO: This is VERY temproary. Testing the nav controller
        let viewController = ScreenName.Area.createViewController(injecting: store)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    var firstRun = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if(firstRun == true) {
            rays.isFirstViewOfSession = firstRun
            contents.alpha = 0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(firstRun == true) {
            UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {[weak self] in
                self?.view.layoutIfNeeded() }
            )
            UIView.animate(withDuration: 0.5, delay: 1.1, options: .curveEaseOut, animations: {[weak self] in
                self?.contents.alpha = 1.0
                self?.view.layoutIfNeeded()
            })
        }
        firstRun = false
    }
}
