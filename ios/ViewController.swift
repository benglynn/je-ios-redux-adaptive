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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateForever(view: progress)
        fade(view: progress, toAlpha: 0.5)
        
        store.state
            .delay(RxTimeInterval(0.5), scheduler: MainScheduler.instance) // TODO temporary simulated delay
            .take(1)
            .subscribe(onNext: {
                let viewController = currentView(forState: $0)
                self.fade(view: self.progress, toAlpha: 0)
                self.fade(view: self.logo, toAlpha: 0) {
                    self.present(viewController, animated: false, completion: nil)
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
        }, completion: { completed in
            self.rotateForever(view: view, duration: duration)
        })
    }


}

