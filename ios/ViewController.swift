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
    @IBOutlet weak var progress: UIImageView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let stateSubscription = store.state
            .delay(RxTimeInterval(5), scheduler: MainScheduler.instance)
            .take(1)
            .subscribe(onNext: self.onState)
        stateSubscription.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onState(state: State) {
        let viewController = currentView(forState: state)
        let rootView = viewController.view!
        rootView.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(viewController)
        self.containerView.addSubview(rootView)
        self.matchAnchors(view1: rootView, view2: self.containerView)
        viewController.didMove(toParentViewController: viewController)
        self.mask.isHidden = true
    }
    
    func matchAnchors(view1: UIView, view2: UIView) {
        NSLayoutConstraint.activate([
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            view1.topAnchor.constraint(equalTo: view2.topAnchor),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor),
        ])
    }


}

