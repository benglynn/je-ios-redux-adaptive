import Foundation

struct ConfigStateSlice: Slice {
    
    let isAdapted: Bool
    let core: CoreConfigSlice
    
    var routes: [Route] { get {
        // Adapters add other slices' routes
        return self.core.routes
        }}
}

let initialConfigStateSlice = ConfigStateSlice(
    isAdapted: false,
    core: initialCoreConfigSlice
)
