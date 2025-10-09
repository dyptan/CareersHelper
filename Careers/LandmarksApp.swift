/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The top-level definition of the app.
*/

import SwiftUI

@main
struct CarrersApp: App {
    var body: some Scene {
        WindowGroup {
            CareerList()
        }
    }
}

#Preview {
    NavigationView {
        CareerList()
    }
}
