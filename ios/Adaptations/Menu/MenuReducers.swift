import Foundation

func activateMenuAdaptation (stateSlice: ConfigStateSlice, action: Actionable) -> ConfigStateSlice {
    
    let nextStateSlice = ConfigStateSlice(
        isAdapted: stateSlice.isAdapted,
        config: stateSlice.config,
        core: CoreConfigSlice(
            isActive: stateSlice.core.isActive,
            reducers: stateSlice.core.reducers,
            routes: [(
                pathPattern: .HomePath,
                screens: [
                    ScreenFamily(screen: .Restaurants, children: [.Home]),
                    ScreenFamily(screen: .Home, children: nil),
                    ]
                ),(
                    pathPattern: .AreaPath,
                    screens: [
                        ScreenFamily(screen: .Restaurants, children: [.Home, .Area]),
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
    )
    return nextStateSlice
}

