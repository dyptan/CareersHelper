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
//    @Test("Career init clamps difficulty and chances")
//    func initClampsValues() throws {
//        let career = Career(
//            id: "Sample",
//            category: .technology,
//            difficulty: 99,     // should clamp to 5
//            chances: -1,        // should clamp to 1
//            income: 80000,
//            summary: "Sample career",
//            icon: "💻",
//            reward: "💵💵💵"
//        )
//
//        #expect(career.difficulty == 5)
//        #expect(career.chances == 1)
//        #expect(!career.id.isEmpty)
//        #expect(career.persona == .tools)
//    }
//
//    @Test("Career Hashable conformance")
//    func hashableConformance() throws {
//        let a = Career(id: "A", category: .arts, difficulty: 3, chances: 3, income: 50000, summary: "", icon: "🎭", reward: "💵")
//        let b = Career(id: "B", category: .arts, difficulty: 3, chances: 3, income: 50000, summary: "", icon: "🎭", reward: "💵")
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
//            chances: 2,
//            income: 80000,
//            summary: "Sample career",
//            icon: "💻",
//            reward: "💵💵💵"
//        )
//        let _ = CareerDetail(career: sample)
//        #expect(true)
//    }
//
//    @Test("Construct CareerList without installing")
//    func constructCareerList() throws {
//        let _ = CareerList()
//        #expect(true)
//    }
//
//    @Test("Register navigation destination without evaluating body")
//    func navigationDestinationRegistration() throws {
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
//        let sample = Career(
//            id: "Navigatable",
//            category: .technology,
//            difficulty: 2,
//            chances: 3,
//            income: 70000,
//            summary: "For navigation test",
//            icon: "💻",
//            reward: "💵💵"
//        )
//
//        let destinationBuilder: (Career) -> CareerDetail = { career in
//            CareerDetail(career: career)
//        }
//
//        let destination = destinationBuilder(sample)
//        let _: CareerDetail = destination
//        #expect(true)
//    }
//}
