import XCTest
import SwiftUI
@testable import Landmarks

final class CareerListNavigationUnitTests: XCTestCase {

    func testCareerConformanceAndInit() throws {
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
        var set = Set<Career>()
        set.insert(sample)
        XCTAssertTrue(set.contains(sample))
        XCTAssertFalse(sample.id.isEmpty)
    }

    func testCareerListBuilds() throws {
        // Build the view once — just ensures it compiles/constructs.
        let _ = CareerList().body
        XCTAssertTrue(true)
    }

    func testDestinationRegistrationCompiles() throws {
        let stack = NavigationStack { Text("Root") }
            .navigationDestination(for: Career.self) { career in
                CareerDetail(career: career)
            }
        let _ = stack.body
        XCTAssertTrue(true)
    }
}
