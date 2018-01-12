import Foundation

struct CoreConfigSlice {
    let isActive: Bool
    let routes: [Route]
}

let initialCoreConfigSlice = CoreConfigSlice(
    isActive: true,
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

// TODO: Stopgap until actions/reducers implemented

let adaptedConfigStateSlice = ConfigStateSlice(
    isAdapted: true,
    core: CoreConfigSlice(
        isActive: true,
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
)

