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
    
    private func present(_ nameStack: [ViewStackItem], on parent: UIViewController) {
        let first = nameStack[0], firstType = first.name.viewControllerType()
        
        let selectedInParent: UIViewController? = {
            switch parent {
            case let tabs as UITabBarController:
                if let matchingChild = (tabs.viewControllers?.first { type(of: $0) == firstType }) {
                    print("Selecting \(first.name) in \(parent)")
                    tabs.selectedViewController = matchingChild
                    return matchingChild
                } else { return nil }
            // TODO: Check for all types of parent
            default: return nil
            }
        }()
        
        let presentedOnParent: UIViewController? = {
            if selectedInParent != nil {
                return nil
            }
            if type(of: parent.presentedViewController) == firstType {
                print("\(first.name) already presented on \(parent)")
                return parent.presentedViewController
            } else {
                print("Presneting \(first.name) on \(parent)")
                let viewController = first.name.createViewController()
                self.present(viewController, animated: false, completion: nil) // TODO: animated true for all but first view
                return viewController
            }
        }()
        
        let selectedOrPresnted = selectedInParent != nil ? selectedInParent! : presentedOnParent!
        
        if let childNames = first.childNames {
            switch selectedOrPresnted {
            case let tabs as UITabBarController:
                tabs.viewControllers = childNames.map { $0.createViewController() } // TODO: don't clobber existing children!
            // TODO: Check for all types of parent
            default:
                fatalError("Unable to add children to an unknown parent type")
            }
        }
        if nameStack.count > 1 {
            present(Array(nameStack[1...]), on: selectedOrPresnted)
        }
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

