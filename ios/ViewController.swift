//
//  ViewController.swift
//  ios
//
//  Created by Ben Glynn on 04/12/2017.
//  Copyright © 2017 Just Eat. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progress: UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rotateForever(view: progress)
        fade(view: progress, toAlpha: 0.5)
        let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
        store.state
            .delay(RxTimeInterval(0.5), scheduler: globalScheduler) // TODO replace with call
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                let viewController = currentView(forState: $0)
                self.fade(view: self.progress, toAlpha: 0)
                self.fade(view: self.logo, toAlpha: 0) { [weak self] in
                    self?.present(viewController, animated: false, completion: nil)
                }
            })
        .disposed(by: disposeBag)
    }
    
    private func fade(view: UIView, toAlpha: CGFloat, completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
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

