import UIKit

func presentRouteEffect(store: Store, currentState: State) {
    if let rootView = UIApplication.shared.keyWindow?.rootViewController { // TODO: root from injector
        if let effect = currentState.core.route?.effect {
            effect.call(store, currentState)
        }
        present(currentState.core.route!.screens, on: rootView, isChild: false, injecting: store)
    }
}
