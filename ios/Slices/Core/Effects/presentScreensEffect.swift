import UIKit

func presentScreensEffect(store: Store, currentState: State) {
    if let rootView = UIApplication.shared.keyWindow?.rootViewController { // TODO: root from injector
        present(currentState.core.screenFamilyStack, on: rootView, isChild: false, injecting: store)
    }
}
