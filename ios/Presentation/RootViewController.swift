import UIKit
import RxSwift

class RootViewController: UIViewController, PresentationRoot {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progress: UIImageView!
    var initialPresentationDelegate: InitialPresentationDelegate!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateForever(view: progress)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fade(view: logo, toAlpha: 1.0)
        fade(view: progress, toAlpha: 0.5)
        self.initialPresentationDelegate.readyToPresent(on: self)
    }
    
    func prepareToPresent(_ callback: @escaping ()->Void) {
        self.fade(view: self.progress, toAlpha: 0)
        self.fade(view: self.logo, toAlpha: 0) {
            callback()
        }
    }
    
    private func fade(view: UIView, toAlpha: CGFloat, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
            view.alpha = toAlpha
        }, completion: { complete in
            completion?()
        })
    }
    
    private func rotateForever(view: UIView, duration: Double = 0.4) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            view.transform = view.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { [weak self] completed in
            self?.rotateForever(view: view, duration: duration)
        })
    }


}

