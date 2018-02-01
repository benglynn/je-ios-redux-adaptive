import Foundation

struct CoreStateSlice: StateSlice /* TODO: Codable */ {
    let isAdapted: Bool
    let path: String
    let screensInSession: Int
    let reducers: [Action: CoreReducer]
    let screenFamilyStack: [ScreenFamily]
    let routes: [Route]
    
    func reduce(with action: Actionable) -> CoreStateSlice {
        if let reducer = self.reducers[action.type] {
            return reducer.reduce(self, action)
        }
        return self
    }
    
    func cloneWith(
        isAdapted: Bool? = nil,
        path: String? = nil,
        screensInSession: Int? = nil,
        reducers: [Action: CoreReducer]? = nil,
        screenFamilyStack: [ScreenFamily]? = nil,
        routes: [Route]? = nil
        ) -> CoreStateSlice {
        return CoreStateSlice(
            isAdapted: isAdapted ?? self.isAdapted,
            path: path ?? self.path,
            screensInSession: screensInSession ?? self.screensInSession,
            reducers: reducers ?? self.reducers,
            screenFamilyStack: screenFamilyStack ?? self.screenFamilyStack,
            routes: routes ?? self.routes
        )
    }
}
