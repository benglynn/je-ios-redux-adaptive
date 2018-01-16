import Foundation

struct ConfigStateSlice: StateSlice {
    
    let isAdapted: Bool
    let config: ConfigConfigSlice
    let core: CoreConfigSlice
    
    var routes: [Route] { get {
        // Adapters + other slices' routes to returned array
        return self.core.routes
        }
    }
    
    func reduce(current: State, with action: Actionable) -> ConfigStateSlice {
        if let reducer = current.config.config.reducers[action.type] {
            return reducer.reduce(current.config, action)
        }
        return current.config
    }
}

let initialConfigStateSlice = ConfigStateSlice(
    isAdapted: false,
    config: initialConfigConfigSlice,
    core: initialCoreConfigSlice
)
