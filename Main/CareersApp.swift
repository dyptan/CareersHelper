import SwiftUI

@main
struct CareersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
