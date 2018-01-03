import Foundation

enum ViewName: String {
    case TabsView
    case RestaurantsView
    case HomeView
    case OrdersView
    case SettingsView
}

struct ParentView {
    let children: [ViewName]
}
