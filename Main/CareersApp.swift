import SwiftUI

@main
struct CareersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PlayerView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlayerView()
    }
}
