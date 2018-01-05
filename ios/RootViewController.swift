//
//  ViewController.swift
//  ios
//
//  Created by Ben Glynn on 04/12/2017.
//  Copyright © 2017 Just Eat. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var progress: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).rootViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rotateForever(view: progress)
        fade(view: progress, toAlpha: 0.5)
        store.state$
            .filter { state in state.config.isAdapted }
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { state in
                self.fade(view: self.progress, toAlpha: 0)
                self.fade(view: self.logo, toAlpha: 0) {
                    let viewStack = compileViewStack(for: state)
                    self.present(viewStack, on: self)
                }
            })
        .disposed(by: disposeBag)
    }
    
    private func present(_ viewStack: [ViewStackItem], on parent: UIViewController) {
        print("Presented view controller: \(String(describing: parent.presentedViewController))")
        let first = viewStack[0]
        if parent.presentedViewController == nil {
            self.present(first.view, animated: false, completion: nil)
            guard let children = first.children else {
                return
            }
            switch first.view {
            case let tabs as UITabBarController:
                tabs.viewControllers = children
            default:
                fatalError("Unable to add children to an unknown parent type")
            }
            
        }
        // TODO: deal with complex view stacks
        // TODO: test coversage validates ancestry?
        
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

