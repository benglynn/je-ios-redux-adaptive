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
        
        let firstAdaptedState$ = store.state$
            .filter { state in state.config.isAdapted }
            .take(1)
        
        let pathUpdate$ = store.state$
            .filter { state in state.config.isAdapted }
            .skip(1)
            .map { $0.core.path }
            .distinctUntilChanged()

        DispatchQueue.global(qos: .background).async { [weak self] in // TODO: subscribeOn instead of this?
            guard let strongSelf = self else { return }
            adaptationService.asObservable()
                .subscribe(onNext: { serviceResponse in
                    let actions: [Actionable] = serviceResponse.actions
                        .filter { $0.active == true }
                        .map { Action(rawValue: $0.type) }
                        .filter { $0 != nil }
                        .map { ActivateAdaptation(type: $0!) }
                        + [UpdateIsAdaptedAction(true)]
                    actions.forEach { store.dispatch($0) }
                }).disposed(by: strongSelf.bag)
        }
            
        firstAdaptedState$
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { state in
                self.fade(view: self.progress, toAlpha: 0)
                self.fade(view: self.logo, toAlpha: 0) {
                    Presenter.present(state, on: self, injecting: store)
                }
            }).disposed(by: bag)
        
        pathUpdate$
            .withLatestFrom(store.state$)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { state in
                Presenter.present(state, on: self, injecting: store)
            }).disposed(by: bag)
    }
    
    private func fade(view: UIView, toAlpha: CGFloat, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
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

