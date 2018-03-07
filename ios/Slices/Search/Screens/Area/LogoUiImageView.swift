import UIKit

@IBDesignable class LogoUiImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }
    
}
