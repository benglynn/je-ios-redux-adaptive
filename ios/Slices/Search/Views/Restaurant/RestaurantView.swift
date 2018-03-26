import UIKit

@IBDesignable class RestaurantView: UIView, NibOwning {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var ratingsView: RatingsView!
    @IBOutlet weak var ratingsCount: UILabel!
    @IBOutlet weak var cuisines: UILabel!
    @IBOutlet weak var new: UILabel!
    @IBOutlet weak var sponsored: UILabel!
    
    func render(restaurant: Restaurant) {
        title.text = restaurant.title
        logo.download(fromLocation: restaurant.logUrl)
        ratingsView.render(rating: restaurant.rating)
        ratingsCount.text = String(restaurant.ratings)
        cuisines.text = restaurant.cuisines
        new.isHidden = !restaurant.isNew
        sponsored.isHidden = !restaurant.isSponsored
        
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

