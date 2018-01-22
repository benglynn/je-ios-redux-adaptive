import Foundation

func activateMenuAdaptation(stateSlice: CoreStateSlice, action: Actionable) -> CoreStateSlice {
    return CoreStateSlice(
        isAdapted: stateSlice.isAdapted,
        path: stateSlice.path,
        screensInSession: stateSlice.screensInSession,
        reducers: stateSlice.reducers,
        screenFamilyStack: stateSlice.screenFamilyStack,
        routes: [(
            pathPattern: .HomePath,
            screens: [
                ScreenFamily(screen: .Restaurants, children: [.MenuHome]),
                ScreenFamily(screen: .MenuHome, children: nil),
                ]
            ),(
                pathPattern: .AreaPath,
                screens: [
                    ScreenFamily(screen: .Restaurants, children: [.MenuHome, .Area]),
                    ScreenFamily(screen: .Area, children: nil),
                    ]
            ),(
                pathPattern: .OrdersPath,
                screens: [
                    ScreenFamily(screen: .Orders, children: nil),
                    ]
            ),(
                pathPattern: .SettingsPath,
                screens: [
                    ScreenFamily(screen: .Settings, children: nil),
                    ]
            )
        ]
    )
}
