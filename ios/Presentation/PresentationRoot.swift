import Foundation

protocol PresentationRoot {
    var presentationDelegate: PresentationDelegate! { get set }
    func prepareToPresent(_ callback: @escaping ()->Void) -> Void
}
