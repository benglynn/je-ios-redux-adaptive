import Foundation

struct CoreStateSlice: StateSlice {
    let isAdapted: Bool
    let path: String
    let screensInSession: Int
    let _reducers: [Action: CoreReducer]
    let _routes: [Route]
    
    func reduce(with action: Actionable) -> CoreStateSlice {
        if let reducer = self._reducers[action.type] {
            return reducer.reduce(self, action)
        }
        return self
    }
}

let initialCoreStateSlice = CoreStateSlice(
    isAdapted: false,
    path: "",
    screensInSession: 0,
    _reducers: [
        .updateIsAdaptedAction: .updateIsAdaptedReducer,
        .updatePathAction: .updatePathReducer,
        .activateMenuAdaptationAction: 	.activateMenuAdaptationReducer
    ],
    _routes: [(
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
