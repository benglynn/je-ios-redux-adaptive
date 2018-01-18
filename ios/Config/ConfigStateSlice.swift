import Foundation

struct ConfigStateSlice: StateSlice {
    
    let isAdapted: Bool
    let config: ConfigConfigSlice
    let core: CoreConfigSlice
    let _reducers: [Action: ConfigReducer]
    
    var routes: [Route] { get {
        // Adapters + other slices' routes to returned array
        return self.core.routes
        }
    }
    
    func reduce(with action: Actionable) -> ConfigStateSlice {
        if let reducer = self._reducers[action.type] {
            return reducer.reduce(self, action)
        }
        return self
    }
}

let initialConfigStateSlice = ConfigStateSlice(
    isAdapted: false,
    config: initialConfigConfigSlice,
    core: initialCoreConfigSlice,
    _reducers: [
        .updateIsAdaptedAction : .updateIsAdaptedReducer,
        .activateMenuAdaptationAction: .activateMenuAdaptationReducer
    ]
)
