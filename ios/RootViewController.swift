import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progress: UIImageView!
    
    private let bag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rotateForever(view: progress)
        fade(view: progress, toAlpha: 0.5)

        let adaptationService = AdaptationService()
        let store = Store(initialState)
        
        DispatchQueue.global(qos: .background).async { [weak self] in // TODO: subscribeOn instead of this?
            guard let strongSelf = self else { return }
            adaptationService.asObservable()
                .subscribe(onNext: { serviceResponse in
                    print("Received \(serviceResponse.actions.count) actions")
                    store.state$.onNext(adaptedState) // TODO: once reduce is implemented, dispatch actions to store instead of this
                }).disposed(by: strongSelf.bag)
        }
        
        store.state$
            .filter { state in state.config.isAdapted }
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { state in
                self.fade(view: self.progress, toAlpha: 0)
                self.fade(view: self.logo, toAlpha: 0) {
                    Route.present(state, on: self, injecting: store)
                }
                
            })
        .disposed(by: bag)
    }
    
    private func fade(view: UIView, toAlpha: CGFloat, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
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

