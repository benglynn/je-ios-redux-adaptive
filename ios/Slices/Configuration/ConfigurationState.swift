import Foundation

struct ConfigurationState: Slice {
    
    struct Core {
        let isActive: Bool
        let routes: [Route]
    }
    
    let isAdapted: Bool
    let core: Core
    
    var routes: [Route] { get {
        // Adapters add other slices' routes
        return self.core.routes
        }}
}

let initialConfigurationState = ConfigurationState(
    isAdapted: false,
    core: ConfigurationState.Core(
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

// TODO: Stopgap until actions/reducers implemented

let adaptedConfigurationState = ConfigurationState(
    isAdapted: true,
    core: ConfigurationState.Core(
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
