import UIKit

func removePresented(store: Store, currentState: State) {
    UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
}
