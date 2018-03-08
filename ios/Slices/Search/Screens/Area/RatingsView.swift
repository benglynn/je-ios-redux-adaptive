import UIKit

@IBDesignable class RatingsView: UIView, NibOwning {

    @IBOutlet weak var starsWidth: NSLayoutConstraint!
    
    let starWidth = CGFloat(16)
    
    func render(rating: Double) {
        starsWidth.constant = CGFloat(rating) * starWidth
    }
    
    // MARK: NibOwning
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }

}
