import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var rays: RaysView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rays.isFirstViewOfSession = true // TODO: from state, don't animate more than once per session
    }
}
