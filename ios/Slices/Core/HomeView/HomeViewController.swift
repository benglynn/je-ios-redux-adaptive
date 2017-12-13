import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var rays: RaysView!
    @IBOutlet weak var contents: UIStackView!
    
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
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.8) {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0) { [weak self] in
                        self?.contents.alpha = 1.0
                    }
                }
            }
        }
        firstRun = false
    }
}
