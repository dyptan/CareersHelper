import SwiftUI

@main
struct Main: App {
    
    
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
