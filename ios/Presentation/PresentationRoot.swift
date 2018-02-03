import Foundation

protocol PresentationRoot {
    var initialPresentationDelegate: InitialPresentationDelegate! { get set }
    func prepareToPresent(_ callback: @escaping ()->Void) -> Void
}
