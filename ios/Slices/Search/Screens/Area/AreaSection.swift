import UIKit
import RxDataSources

struct AreaSection {
    var sectionType: AreaSectionType
    var items: [Restaurant]
}

extension AreaSection: SectionModelType {
    typealias Item = Restaurant
    
    init(original: AreaSection, items: [Restaurant]) {
        self = original
        self.items = items
    }
}
