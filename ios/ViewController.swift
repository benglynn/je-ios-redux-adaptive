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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mask: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progress: UIImageView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateForever(view: progress)
        fade(view: logo, toAlpha: 0)
        fade(view: progress, toAlpha: 1)
        
        let stateSubscription = store.state
            .delay(RxTimeInterval(1), scheduler: MainScheduler.instance) // TODO temporary simulated delay
            .take(1)
            .subscribe(onNext: {
                let viewController = currentView(forState: $0)
                viewController.modalTransitionStyle = .crossDissolve
                self.present(viewController, animated: true, completion: nil)
            })
        stateSubscription.disposed(by: disposeBag)
    }
    
    private func fade(view: UIView, toAlpha: CGFloat, duration: Double = 0.2) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            view.alpha = toAlpha
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

