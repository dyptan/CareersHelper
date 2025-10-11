import SwiftUI

@main
struct CareersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CareerList()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CareerList()
    }
}
