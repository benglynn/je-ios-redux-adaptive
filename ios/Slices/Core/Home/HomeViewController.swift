import UIKit

class HomeViewController: UIViewController, StoreDepending {
    
    internal var store: Store!
    
    func setStore(store: Store) {
        self.store = store
    }

    @IBOutlet weak var rays: RaysView!
    @IBOutlet weak var contents: UIStackView!
    
    @IBAction func tapSearch(_ sender: Any) {
        self.store.dispatch(UpdatePathAction("bs14dj"))
    }
    
    var firstRun = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(firstRun == true) {
            rays.isFirstViewOfSession = firstRun
            contents.alpha = 0
        }
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