import Foundation

struct AreaStateSlice: Reducible /* TODO: Codable */ {
    let reducers: [Action : AreaReducer]
    let restaurants: [Restaurant]?
}

extension AreaStateSlice {
    func reduce(_ action: Actionable) -> AreaStateSlice {
        return self // TODO
    }
    
    
}
