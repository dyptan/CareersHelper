import SwiftUI

@main
struct CareersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootList()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootList()
    }
}
