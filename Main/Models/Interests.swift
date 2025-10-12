//
//  Interests.swift
//  CareersApp
//
//  Created by Admin on 10/12/25.
//  Copyright © 2025 Apple. All rights reserved.
//


enum Interests: String, CaseIterable, Identifiable, Codable {
    case people = "Working with People"
    case tools = "Tools & Machines"
    case creative = "Creative & Arts"
    case outdoors = "Land & Outdoors"
    case sports = "Sports & Fitness"
    case science = "Science & Health"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .people: return "🤝"
        case .tools: return "🛠️"
        case .creative: return "🎨"
        case .outdoors: return "🌿"
        case .sports: return "🏅"
        case .science: return "🔬"
        }
    }

    var shortTitle: String {
        switch self {
        case .people: return "People"
        case .tools: return "Tools"
        case .creative: return "Creative"
        case .outdoors: return "Outdoors"
        case .sports: return "Sports"
        case .science: return "Science"
        }
    }
}