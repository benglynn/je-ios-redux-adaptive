import Foundation

struct PresentMenuAction: Actionable {
    let type: Action = .presentMenu
}

struct DismissMenuAction: Actionable {
    let type: Action = .dismissMenu
}
