import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var rays: RaysView!
    @IBOutlet weak var contents: UIStackView!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var barBottom: NSLayoutConstraint!
    
    var firstRun = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(firstRun == true) {
            rays.isFirstViewOfSession = firstRun
            contents.alpha = 0
            barBottom.constant = 49
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(firstRun == true) {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.barBottom.constant = 0
                self?.view.layoutIfNeeded()
            }
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.contents.alpha = 1.0
                self?.view.layoutIfNeeded()
            }
        }
        firstRun = false
    }
}
