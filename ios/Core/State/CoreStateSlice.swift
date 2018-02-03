import Foundation

struct CoreStateSlice: Reducible /* TODO: Codable */ {
    let isAdapted: Bool
    let path: String
    let screensInSession: Int
    let reducers: [Action: CoreReducer]
    let effects: [Action: CoreEffect]
    let screenFamilyStack: [ScreenFamily]
    let routes: [Route]
}

extension CoreStateSlice {
    func reduce(_ action: Actionable) -> CoreStateSlice {
        if let reducer = self.reducers[action.type] {
            return reducer.call(self, action)
        }
        return self // TODO: return nil if no change
    }
}

extension CoreStateSlice {
    func callSideEffects(for action: Actionable, with latestState: State, store: Store) {
        if let effect = self.effects[action.type] {
            effect.call(store, latestState)
        }
    }
}

extension CoreStateSlice {
    func cloneWith(
        isAdapted: Bool? = nil,
        path: String? = nil,
        screensInSession: Int? = nil,
        reducers: [Action: CoreReducer]? = nil,
        effects: [Action: CoreEffect]? = nil,
        screenFamilyStack: [ScreenFamily]? = nil,
        routes: [Route]? = nil
        ) -> CoreStateSlice {
        return CoreStateSlice(
            isAdapted: isAdapted ?? self.isAdapted,
            path: path ?? self.path,
            screensInSession: screensInSession ?? self.screensInSession,
            reducers: reducers ?? self.reducers,
            effects: effects ?? self.effects,
            screenFamilyStack: screenFamilyStack ?? self.screenFamilyStack,
            routes: routes ?? self.routes
        )
    }
}
