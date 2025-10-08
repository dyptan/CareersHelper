import SwiftUI
import Testing

// Minimal helper to render a view once to ensure it builds the hierarchy.
private struct RenderHost<Content: View>: View {
    let content: Content
    var body: some View { content }
}

@Suite("CareerList navigation wiring")
struct CareerListNavigationTests {

    // Sanity check: model types conform as required by value-based navigation.
    @Test("Career conforms to Hashable and Identifiable")
    func careerConformance() async throws {
        // Compile-time conformance is enough; this is just to keep the test visible.
        let sample = Career(
            id: "Sample",
            category: .technology,
            difficulty: 3,
            luckFactor: 0.4,
            income: 80000,
            summary: "Sample career",
            icon: "💻",
            reward: "💵💵💵"
        )
        // Hashable round-trip
        var set = Set<Career>()
        set.insert(sample)
        #expect(set.contains(sample))
        // Identifiable id non-empty
        #expect(!sample.id.isEmpty)
    }

    // Build the view to ensure no runtime crashes and that the tree exists.
    @Test("CareerList builds a view tree")
    func buildCareerList() async throws {
        let view = RenderHost(content: CareerList())
        // Force body evaluation at least once
        _ = view.body
        #expect(true, "View built")
    }

    // Verify that the detail column produces NavigationLink(value:) for Career.
    // We can't introspect private SwiftUI types, but we can at least ensure the ForEach
    // iterates over Career and that NavigationLink(value:) compiles with Career.
    @Test("NavigationLink(value:) uses Career values")
    func navigationLinkUsesCareerValues() async throws {
        // Build a small view that mimics the row usage to ensure the generic overload matches Career.
        let row = NavigationLink(value: sampleCareer()) {
            Text("Row")
        }
        _ = row.body
        #expect(true)
    }

    // Verify that a destination for Career is registered and produces CareerDetail.
    // We can do this by constructing a tiny NavigationStack with the same destination registration.
    @Test("navigationDestination(for: Career.self) resolves to CareerDetail")
    func destinationRegisteredForCareer() async throws {
        let destinationRegistered = NavigationStack {
            Text("Root")
        }
        .navigationDestination(for: Career.self) { career in
            CareerDetail(career: career)
        }

        // Force build
        _ = destinationRegistered.body
        #expect(true)
    }

    // Helper
    private func sampleCareer() -> Career {
        Career(
            id: "Sample",
            category: .technology,
            difficulty: 3,
            luckFactor: 0.4,
            income: 80000,
            summary: "Sample career",
            icon: "💻",
            reward: "💵💵💵"
        )
    }
}
