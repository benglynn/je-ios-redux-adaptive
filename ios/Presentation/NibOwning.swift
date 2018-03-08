import UIKit

protocol NibOwning where Self: UIView {}

extension NibOwning {
    func initFromNib() {
        let bundle = Bundle(for: type(of: self))
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        let inib = nib.instantiate(withOwner: self, options: nil)
        let view = inib.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
