import UIKit
import RxDataSources

class ResultCollectionViewCell: UICollectionViewCell {
    var layout: AreaFlowLayout!
    @IBOutlet weak var restaurantView: RestaurantView!
    
    func update(_ restaurant: Restaurant) {
        restaurantView.render(restaurant: restaurant)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let newAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        let width = layout.cellWidth ?? layoutAttributes.size.width
        frame.size.width = width
        newAttributes.bounds.size.width = width
        layoutIfNeeded()
        newAttributes.bounds.size.height = systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return newAttributes
    }
    
    override func awakeFromNib() {
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8.0
    }

}
