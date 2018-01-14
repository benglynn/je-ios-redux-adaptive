import Foundation

struct ConfigConfigSlice {
    let reducers: [Action: ConfigReducer]
}

let initialConfigConfigSlice = ConfigConfigSlice(
    reducers: [.updateIsAdaptedAction : .updateIsAdaptedReducer]
)
