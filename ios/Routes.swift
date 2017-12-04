import Foundation
import UIKit

func currentView(forState state: State) -> UIViewController {
    let viewName = state.core.routes[0].viewName.rawValue
    let storyboard = UIStoryboard(name: viewName, bundle: nil)
    let viewController = storyboard.instantiateInitialViewController()
    return viewController!
}
