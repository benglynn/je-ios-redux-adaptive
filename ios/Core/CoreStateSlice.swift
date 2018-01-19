import Foundation

struct CoreStateSlice: StateSlice {
    let isAdapted: Bool
    let path: String
    let screensInSession: Int
    let reducers: [Action: CoreReducer]
    let screenFamilyStack: [ScreenFamily]?
    let routes: [Route]
    
    func reduce(with action: Actionable) -> CoreStateSlice {
        if let reducer = self.reducers[action.type] {
            return reducer.reduce(self, action)
        }
        return self
    }
}

let initialCoreStateSlice = CoreStateSlice(
    isAdapted: false,
    path: "",
    screensInSession: 0,
    reducers: [
        .updateIsAdaptedAction: .updateIsAdaptedReducer,
        .updatePathAction: .updatePathReducer,
        .activateMenuAdaptationAction: 	.activateMenuAdaptationReducer
    ],
    screenFamilyStack: nil,
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
