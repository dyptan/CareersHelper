import SwiftUI

@main
struct CarrersApp: App {
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
