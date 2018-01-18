import Foundation

struct CoreStateSlice: StateSlice {
    
    let path: String
    let screensInSession: Int
    let _reducers: [Action: CoreReducer]
    
    func reduce(with action: Actionable) -> CoreStateSlice {
        if let reducer = self._reducers[action.type] {
            return reducer.reduce(self, action)
        }
        return self
    }
}

let initialCoreStateSlice = CoreStateSlice(
    path: "",
    screensInSession: 0,
    _reducers: [.updatePathAction: .updatePathReducer]
)
