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
        .updatePathAction: .presentScreensEffect,
        .presentMenu: .presentScreensEffect,
        .dismissLastAction: .presentScreensEffect,
        .resetAction: .presentScreensEffect,
    ],
    screenFamilyStack: [],
    route: nil,
    routes: [Route(
        pathPattern: .HomePath,
        screens: [
            ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
            ScreenFamily(screen: .Restaurants, children: [.Home]),
            ScreenFamily(screen: .Home, children: nil),
            ],
        effect: nil
        ), Route(
            pathPattern: .AreaPath,
            screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Restaurants, children: [.Home, .Area]),
                ScreenFamily(screen: .Area, children: nil),
                ],
            effect: .searchEffect
        ), Route(
            pathPattern: .OrdersPath,
            screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Orders, children: nil),
                ],
            effect: nil
        ), Route(
            pathPattern: .SettingsPath,
            screens: [
                ScreenFamily(screen: .Tabs, children: [.Restaurants, .Orders, .Settings]),
                ScreenFamily(screen: .Settings, children: nil),
                ],
            effect: nil
        )
    ]
)

