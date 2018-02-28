import Foundation

struct CoreStateSlice: Reducible /* TODO: Codable */ {
    let isAdapted: Bool
    let path: String
    let screensInSession: Int
    let reducers: [Action: CoreReducer]
    let effects: [Action: Effect]
    let screenFamilyStack: [ScreenFamily]
    let route: Route?
    let routes: [Route]
}
