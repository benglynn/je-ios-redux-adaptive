import UIKit

@IBDesignable class RaysView: UIView {
    
    private var isInterfaceBuilder = false
    var isFirstViewOfSession = false
    let durationMultiplier = 1.0
    
    private struct rayShape {
        let startDeg: CGFloat
        let endDeg: CGFloat
        let rgbColour: [CGFloat]
    }
    
    private let rayShapes = [
        rayShape(startDeg: 0, endDeg: 12, rgbColour: [252, 90, 93]),
        rayShape(startDeg: 12, endDeg: 19, rgbColour: [0, 172, 65]),
        rayShape(startDeg: 19, endDeg: 37, rgbColour: [149, 214, 0]),
        rayShape(startDeg: 37, endDeg: 48, rgbColour: [226, 231, 31]),
        rayShape(startDeg: 48, endDeg: 56, rgbColour: [47, 125, 225]),
        rayShape(startDeg: 56, endDeg: 137, rgbColour: [43, 172, 228]),
        rayShape(startDeg: 137, endDeg: 187, rgbColour: [125, 202, 235]),
        rayShape(startDeg: 187, endDeg: 201, rgbColour: [243, 108, 33]),
        rayShape(startDeg: 201, endDeg: 234, rgbColour: [249, 159, 30]),
        rayShape(startDeg: 234, endDeg: 244, rgbColour: [254, 215, 0]),
        rayShape(startDeg: 244, endDeg: 348, rgbColour: [255, 255, 255]),
        rayShape(startDeg: 348, endDeg: 360, rgbColour: [250, 0, 41]),
    ]

    override func draw(_ rect: CGRect) {
        
        self.layer.sublayers?.forEach({ layer in
            layer.removeFromSuperlayer()
        })
        
        let restingTranslate = CATransform3DMakeTranslation(-rect.midX + 70, rect.midY - 130, 0.0)
        let restingTranslateRotate = CATransform3DRotate(restingTranslate, .pi * (5 / 180), 0.0, 0.0, 1.0)
        layer.transform = restingTranslateRotate
        layer.backgroundColor = UIColor.white.cgColor
        let isAnimating = isFirstViewOfSession && !isInterfaceBuilder
        
        // Underlying layer animation
        
        if(isAnimating) {
            CATransaction.setDisableActions(true)
            layer.backgroundColor = UIColor(red: 250/255, green: 0/255, blue: 41/255, alpha: 1.0).cgColor
            let startTranslate = CATransform3DMakeTranslation(-rect.midX + 210.0, rect.midY - 210, 0.0)
            let startTranslateRotate = CATransform3DRotate(startTranslate, .pi * (-30 / 180), 0.0, 0.0, 1.0)
            let anim = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            anim.duration = 1.7 * durationMultiplier
            anim.fromValue = startTranslateRotate
            anim.toValue = restingTranslateRotate
            anim.fillMode = kCAFillModeBackwards
            layer.add(anim, forKey: nil)
        }
        
        // Individual rays and ray animation
        
        let raysCenter = CGPoint(x: rect.midX, y: rect.midY)
        let rayLength = 2 * CGFloat(max(rect.height, rect.width))
        
        _ = rayShapes.enumerated().map { (index, ray) -> CAShapeLayer in
            
            let startRad = CGFloat(.pi * (ray.startDeg / 180.0))
            let endRad = CGFloat(.pi * (ray.endDeg / 180.0))
            let midRad = CGFloat(.pi * (ray.endDeg - ray.startDeg) / 180.0)
            let rayLayerCenter = CGPoint(x: 0.0, y: 0.0)
            
            let rayPath = UIBezierPath()
            rayPath.move(to: rayLayerCenter)
            rayPath.addArc(withCenter: rayLayerCenter, radius: rayLength, startAngle: startRad, endAngle: endRad, clockwise: true)
            rayPath.close()
            
            let squarePath = UIBezierPath(rect: CGRect(x: -rayLength/2, y: -rayLength/2, width: rayLength, height: rayLength))
            let squareRotate = CGAffineTransform.init(rotationAngle: midRad)
            squarePath.apply(squareRotate)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = rayPath.cgPath
            maskLayer.fillColor = UIColor.black.cgColor
            
            let rayLayer = CAShapeLayer()
            rayLayer.position = raysCenter
            rayLayer.path = squarePath.cgPath
            rayLayer.fillColor = UIColor(red: ray.rgbColour[0]/255, green: ray.rgbColour[1]/255, blue: ray.rgbColour[2]/255, alpha: 1.0).cgColor
            rayLayer.mask = maskLayer
            self.layer.addSublayer(rayLayer)
            
            if (isAnimating) {
                let startScale = CATransform3DMakeScale(0.0001, 0.0001, 1.0)
                let endTransform = rayLayer.transform
                let anim = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
                anim.fromValue = startScale
                anim.toValue = endTransform
                anim.duration = 0.5 * durationMultiplier
                anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
                anim.beginTime = CACurrentMediaTime() + (Double(index) * 0.06)
                anim.fillMode = kCAFillModeBackwards
                rayLayer.transform = endTransform
                rayLayer.add(anim, forKey: nil)
            }
            return rayLayer
        }
        isFirstViewOfSession = false
    }
    
    private func initLayout() {
        self.contentMode = .redraw
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        isInterfaceBuilder = true
        self.layer.sublayers?.forEach({ layer in
            layer.setNeedsDisplay()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }


}
