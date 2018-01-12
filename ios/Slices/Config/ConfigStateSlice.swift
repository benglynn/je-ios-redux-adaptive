import Foundation

struct ConfigStateSlice: StateSlice {
    
    let isAdapted: Bool
    let core: CoreConfigSlice
    
    var routes: [Route] { get {
        // Adapters add other slices' routes
        return self.core.routes
        }
    }
    
    func reduce(current: State, with action: Actionable) -> ConfigStateSlice {
        return current.config
    }
}

let initialConfigStateSlice = ConfigStateSlice(
    isAdapted: false,
    core: initialCoreConfigSlice
)
