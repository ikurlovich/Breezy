import SwiftUI

@main
struct BreezyApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .preferredColorScheme(.light)
        }
    }
}
