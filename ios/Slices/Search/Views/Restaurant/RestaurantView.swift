import UIKit

@IBDesignable class RestaurantView: UIView, NibOwning {
    
    @IBOutlet weak var title: UILabel!
    
    func render(restaurant: Restaurant) {
        title.text = restaurant.title
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

