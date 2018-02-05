import UIKit

class MenuSettingsViewController: UIViewController, Presentable {
    
    // MARK: - Presentable
    static var storyboardName = "MenuSettings"
    var store: Store!
    
    // MARK: - Interface Builder
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func tapClose(_ sender: Any) {
        store.dispatch(DismissLastScreenFamilyAction())
    }
    
    @IBAction func tapReset(_ sender: Any) {
        store.dispatch(PresentResetScreenAction())
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let settingsView = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController() as! SettingsViewController
        settingsView.setStore(store: store)
        addChildViewController(settingsView)
        settingsView.view.frame = containerView.frame
        settingsView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(settingsView.view)
        settingsView.didMove(toParentViewController: self)
    }
    
}

