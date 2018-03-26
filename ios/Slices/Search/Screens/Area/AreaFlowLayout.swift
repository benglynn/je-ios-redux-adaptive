import UIKit
import RxSwift

class AreaFlowLayout: UICollectionViewFlowLayout {
    
    var cellWidth: CGFloat? = nil
    var columns: Int? = nil
    var lastSafeWidth: CGFloat = 0
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let safeWidth: CGFloat = min(collectionView!.bounds.width, collectionView!.safeAreaLayoutGuide.layoutFrame.width)
        if safeWidth != lastSafeWidth {
            lastSafeWidth = safeWidth
            columns = Int(max(1, floor( (safeWidth - sectionInset.left + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing) )))
            let interCellSpace = CGFloat(columns! - 1) * minimumInteritemSpacing
            cellWidth = floor( (safeWidth - sectionInset.left - interCellSpace - sectionInset.right) / CGFloat(columns!) )
            invalidateLayout()
        }
        if let attributes = super.layoutAttributesForElements(in: rect) {
            return columns! > 1 ? matchRowCellHeights(in: attributes) : attributes
        }
        return nil
    }
    
    func matchRowCellHeights(in attributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        var newAttributes = [UICollectionViewLayoutAttributes]()
        var rowMidY: CGFloat? = nil
        var row = [UICollectionViewLayoutAttributes]()
        for element in attributes {
            if element.representedElementCategory == .cell {
                if rowMidY == nil { rowMidY = element.frame.midY }
                if element.frame.midY > rowMidY! {
                    if row.count > 1 {
                        var rowHeight = row[0].frame.size.height
                        for rowElement in row[1...] { rowHeight = max(rowElement.size.height, rowHeight) }
                        for rowElement in row {
                            if rowElement.size.height != rowHeight {
                                let increase = rowHeight - rowElement.size.height
                                rowElement.size.height = rowHeight
                                rowElement.frame.offsetBy(dx: 0, dy: -increase/2)
                            }
                        }
                    }
                    newAttributes.append(contentsOf: row)
                    row.removeAll()
                    rowMidY = element.frame.midY
                }
                row.append(element.copy() as! UICollectionViewLayoutAttributes)
            } else { newAttributes.append(element) }
        }
        return newAttributes
    }
    
    
}
