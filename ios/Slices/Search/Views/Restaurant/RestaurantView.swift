import UIKit

@IBDesignable class RestaurantView: UIView, NibOwning {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var ratingsView: RatingsView!
    
    func render(restaurant: Restaurant) {
        title.text = restaurant.title
        logo.download(fromLocation: restaurant.logUrl)
        ratingsView.render(rating: restaurant.rating)
        print("\(restaurant.title): \(restaurant.rating)")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8.0
        clipsToBounds = true
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

