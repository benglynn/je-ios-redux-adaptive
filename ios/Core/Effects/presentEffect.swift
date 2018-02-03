import UIKit

func presentEffect(store: Store, currentState: State) {
    if let rootView = UIApplication.shared.keyWindow?.rootViewController as? RootViewController {
        Presenter.present(currentState, on: rootView, injecting: store)
    }
}
