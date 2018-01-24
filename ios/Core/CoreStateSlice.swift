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
    
    func cloneWithOverrides(
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

let initialCoreStateSlice = CoreStateSlice(
    isAdapted: false,
    path: "",
    screensInSession: 0,
    reducers: [
        .updateIsAdaptedAction: .updateIsAdaptedReducer,
        .resetAction: .resetReducer,
        .updatePathAction: .updatePathReducer,
        .dismissLastAction: .dismissLastReducer,
        .activateMenuAdaptationAction: 	.activateMenuAdaptationReducer
    ],
    screenFamilyStack: [],
    routes: [(
        pathPattern: .HomePath,
        screens: [
            ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
            ScreenFamily(screen: .Restaurants, children: [.Home]),
            ScreenFamily(screen: .Home, children: nil),
            ]
        ),(
            pathPattern: .AreaPath,
            screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Restaurants, children: [.Home, .Area]),
                ScreenFamily(screen: .Area, children: nil),
                ]
        ),(
            pathPattern: .OrdersPath,
            screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Orders, children: nil),
                ]
        ),(
            pathPattern: .SettingsPath,
            screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Settings, children: nil),
                ]
        )
    ]
)
