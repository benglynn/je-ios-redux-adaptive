import Foundation

let initialCoreStateSlice = CoreStateSlice(
    isAdapted: false,
    path: "",
    screensInSession: 0,
    reducers: [
        .updateIsAdaptedAction: .updateIsAdaptedReducer,
        .resetAction: .presentResetScreenReducer,
        .updatePathAction: .updatePathReducer,
        .dismissLastAction: .dismissLastScreenFamilyReducer,
        .activateMenuAdaptationAction:     .activateMenuAdaptationReducer
    ],
    effects: [
        .initState: .removePresented,
        .updatePathAction: .presentEffect,
        .presentMenu: .presentEffect,
        .dismissLastAction: .presentEffect,
        .resetAction: .presentEffect,
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

