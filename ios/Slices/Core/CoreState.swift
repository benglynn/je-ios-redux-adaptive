import Foundation

struct CoreState: Slice {
    let path: String
}

struct CoreConfigurationState {
    
}

let initialCoreState = CoreState(
    path: ""
)
