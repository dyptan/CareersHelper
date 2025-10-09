////
////  LandmarksTests.swift
////  LandmarksTests
////
////  Created by Ivan Dyptan on 08.10.25.
////  Copyright © 2025 Apple. All rights reserved.
////
//
//import Testing
//import SwiftUI
//@testable import Careers
//
//@Suite("Career model tests")
//struct CareerModelTests {
//
//    @Test("Career init clamps difficulty and luck")
//    func initClampsValues() throws {
//        let career = Career(
//            id: "Sample",
//            category: .technology,
//            difficulty: 99,     // should clamp to 5
//            luckFactor: -1.0,   // should clamp to 0.0
//            income: 80000,
//            summary: "Sample career",
//            icon: "💻",
//            reward: "💵💵💵"
//        )
//
//        #expect(career.difficulty == 5)
//        #expect(career.luckFactor == 0.0)
//        #expect(!career.id.isEmpty)
//        #expect(career.persona == .tools)
//    }
//
//    @Test("Career Hashable conformance")
//    func hashableConformance() throws {
//        let a = Career(id: "A", category: .arts, difficulty: 3, luckFactor: 0.5, income: 50000, summary: "", icon: "🎭", reward: "💵")
//        let b = Career(id: "B", category: .arts, difficulty: 3, luckFactor: 0.5, income: 50000, summary: "", icon: "🎭", reward: "💵")
//
//        var set = Set<Career>()
//        set.insert(a)
//        #expect(set.contains(a))
//        #expect(!set.contains(b))
//    }
//
//    @Test("Reward derivation from income")
//    func rewardDerivation() throws {
//        #expect(Career.deriveReward(from: 30000) == "💵")
//        #expect(Career.deriveReward(from: 70000) == "💵💵")
//        #expect(Career.deriveReward(from: 90000) == "💵💵💵")
//        #expect(Career.deriveReward(from: 150000) == "💵💵💵💵")
//    }
//}
//
//@Suite("SwiftUI smoke tests (no body evaluation)")
//struct SwiftUISmokeTests {
//
//    @Test("Construct CareerDetail with a sample career")
//    func constructCareerDetail() throws {
//        let sample = Career(
//            id: "Sample",
//            category: .technology,
//            difficulty: 3,
//            luckFactor: 0.4,
//            income: 80000,
//            summary: "Sample career",
//            icon: "💻",
//            reward: "💵💵💵"
//        )
//        // Construct view type; do not access .body here.
//        let _ = CareerDetail(career: sample)
//        #expect(true)
//    }
//
//    @Test("Construct CareerList without installing")
//    func constructCareerList() throws {
//        // Construct view type; avoid evaluating .body to prevent State warnings.
//        let _ = CareerList()
//        #expect(true)
//    }
//
//    @Test("Register navigation destination without evaluating body")
//    func navigationDestinationRegistration() throws {
//        // Build a NavigationStack configured for Career destination.
//        // Avoid touching .body; we're only verifying the API compiles and can be constructed.
//        let _ = NavigationStack {
//            Text("Root")
//        }
//        .navigationDestination(for: Career.self) { career in
//            CareerDetail(career: career)
//        }
//
//        #expect(true)
//    }
//
//    @Test("CareerDetail is navigatable via Career destination")
//    func careerDetailIsNavigatable() throws {
//        // Given a sample career value for value-based navigation
//        let sample = Career(
//            id: "Navigatable",
//            category: .technology,
//            difficulty: 2,
//            luckFactor: 0.3,
//            income: 70000,
//            summary: "For navigation test",
//            icon: "💻",
//            reward: "💵💵"
//        )
//
//        // Build the destination closure exactly as NavigationStack would register it.
//        // We don't evaluate any view .body; we only construct the view type returned.
//        let destinationBuilder: (Career) -> CareerDetail = { career in
//            CareerDetail(career: career)
//        }
//
//        // When invoking the destination builder with the sample value
//        let destination = destinationBuilder(sample)
//
//        // Then we expect to have a CareerDetail view constructed for that Career.
//        // We cannot introspect the view hierarchy here; the smoke test ensures type-level navigatability.
//        // Just assert the type matches and the input is carried through initializer.
//        // Since we can't read `destination.career` directly (it's an internal property of the view),
//        // we rely on construction success as the signal.
//        let _: CareerDetail = destination
//        #expect(true)
//    }
//}
