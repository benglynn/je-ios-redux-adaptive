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
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let stateSubscription = store.state.subscribe(onNext: {
            let viewController = currentView(forState: $0)
            let rootView = viewController.view!
            rootView.translatesAutoresizingMaskIntoConstraints = false
            self.addChildViewController(viewController)
            self.containerView.addSubview(rootView)
            NSLayoutConstraint.activate([
                rootView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                rootView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                rootView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
                rootView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            ])
            viewController.didMove(toParentViewController: viewController)
            
        })
        stateSubscription.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

