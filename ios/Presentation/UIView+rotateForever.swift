import UIKit

extension UIView {
    func rotateForever(duration: Double = 0.4) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.transform = self.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { [weak self] completed in
            self?.rotateForever(duration: duration)
        })
    }
}

