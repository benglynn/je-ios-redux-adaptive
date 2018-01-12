import Foundation

struct CoreStateSlice: Slice {
    let path: String
}

struct CoreConfigurationState {
    
}

let initialCoreStateSlice = CoreStateSlice(
    path: ""
)
