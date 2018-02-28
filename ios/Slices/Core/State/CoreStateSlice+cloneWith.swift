import Foundation

extension CoreStateSlice {
    func cloneWith(
        isAdapted: Bool? = nil,
        path: String? = nil,
        screensInSession: Int? = nil,
        reducers: [Action: CoreReducer]? = nil,
        effects: [Action: Effect]? = nil,
        screenFamilyStack: [ScreenFamily]? = nil,
        route: Optional<Route>? = nil,
        routes: [Route]? = nil
        ) -> CoreStateSlice {
        
        return CoreStateSlice(
            isAdapted: isAdapted ?? self.isAdapted,
            path: path ?? self.path,
            screensInSession: screensInSession ?? self.screensInSession,
            reducers: reducers ?? self.reducers,
            effects: effects ?? self.effects,
            screenFamilyStack: screenFamilyStack ?? self.screenFamilyStack,
            route: value(from: route, or: self.route),
            routes: routes ?? self.routes
        )
    }
}
